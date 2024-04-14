import { LightningElement,api } from 'lwc';
import createContactForm from '@salesforce/apex/ContactProvider.createContactForm';
import saveSign from '@salesforce/apex/ContactProvider.saveSign';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//Mobile Touch variables
let isDrawing = false;
let signaturePoints = [];
//let lastUpdateTime = 0;
//const minTimeBetweenDraws = 16; // Minimum time between draws in milliseconds (approximately 60 frames per second)

//declaration of variables for calculations
let isDownFlag, 
    isDotFlag = false,
    prevX = 0,
    currX = 0,
    prevY = 0,
    currY = 0;            
       
let x = "#0000A0"; //blue color
let y = 1.5; //weight of line width and dot.       

let canvasElement, ctx; //storing canvas context
let attachment; //holds attachment information after saving the sigture on canvas
let dataURL,convertedDataURI; //holds image data

export default class ContactFormCompo extends LightningElement {


    contactObject = {'sobjectType' : 'Contact'}
    result
    error
    fileData
    fileSizeInBytes;
    fileSizeInMB; // Add this property to store the file size in MB
    
    openfileUpload(event) {
        const file = event.target.files[0]

        this.fileSizeInBytes = file.size; // Store the file size in bytes
        this.fileSizeInMB = (this.fileSizeInBytes / (1024 * 1024)).toFixed(2); // Convert to MB and round to 2 decimal places

        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1]
            this.fileData = {
                'filename': file.name,
                'base64': base64,
                'Id': this.contactObject.Id
                
            }
            console.log(this.fileData)
        }
        reader.readAsDataURL(file)
    }

    
    removeFile() {
        this.fileData = null;
    }

    handleInputFirstName(event){
        this.contactObject.FirstName = event.detail.value;      
        console.log(event.detail.value)
    }

    handleInputLastName(event){
        this.contactObject.LastName = event.detail.value;
        console.log(event.detail.value)
    }
    createContactHandler(){
        console.log('i am from createContactHandler');
        
        
        //set to draw behind current content
        ctx.globalCompositeOperation = "destination-over";
        ctx.fillStyle = "#FFF"; //white
        ctx.fillRect(0,0,canvasElement.width, canvasElement.height); 

        //convert to png image as dataURL
        dataURL = canvasElement.toDataURL("image/png");
        //convert that as base64 encoding
        convertedDataURI = dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
        
        const {base64, filename, Id} = this.fileData

        createContactForm({strSignElement: convertedDataURI,objCon : this.contactObject,base64, filename})
        .then((result) => {
          this.result = result;  
          //this.fileData=null;        
          this.error = undefined;          
          console.log(this.result);          
          //window.open('https://agrawalindustries2-dev-ed.my.site.com/contactform/', '_self');
      })
      .catch((error) => {
          this.error = error;
          this.result = undefined;
          console.log("Message = "+JSON.stringify(error));
      });
   
    }    

    //@api recordId;

    //event listeners added for drawing the signature within shadow boundary
    constructor() {
        super();
        this.template.addEventListener('mousemove', this.handleMouseMove.bind(this));
        this.template.addEventListener('mousedown', this.handleMouseDown.bind(this));
        this.template.addEventListener('mouseup', this.handleMouseUp.bind(this));
        this.template.addEventListener('mouseout', this.handleMouseOut.bind(this));

        //Touch Screen Event Listener
        this.template.addEventListener('touchstart', this.handleTouchStart.bind(this));
        this.template.addEventListener('touchmove', this.handleTouchMove.bind(this));
        this.template.addEventListener('touchend', this.handleTouchEnd.bind(this));
    }

    //retrieve canvase and context
    renderedCallback(){
        canvasElement = this.template.querySelector('canvas');
        ctx = canvasElement.getContext("2d");

         // Add the CSS property to disable touch gestures
        canvasElement.style.touchAction = 'none';
    }
    
    //handler for mouse move operation
    handleMouseMove(event){
        this.searchCoordinatesForEvent('move', event);      
    }
    
    //handler for mouse down operation
    handleMouseDown(event){
        this.searchCoordinatesForEvent('down', event);         
    }
    
    //handler for mouse up operation
    handleMouseUp(event){
        this.searchCoordinatesForEvent('up', event);       
    }

    //handler for mouse out operation
    handleMouseOut(event){
        this.searchCoordinatesForEvent('out', event);         
    }

    /*
        handler to perform save operation.
        save signature as attachment.
        after saving shows success or failure message as toast
    */
    handleSaveClick(){    
        //set to draw behind current content
        ctx.globalCompositeOperation = "destination-over";
        ctx.fillStyle = "#FFF"; //white
        ctx.fillRect(0,0,canvasElement.width, canvasElement.height); 

        //convert to png image as dataURL
        dataURL = canvasElement.toDataURL("image/png");
        //convert that as base64 encoding
        convertedDataURI = dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
        
        //call Apex method imperatively and use promise for handling sucess & failure
        saveSign({strSignElement: convertedDataURI,recId : this.recordId})
            .then(result => {
                //this.ContentDocumentLink = result;
                //console.log('ContentDocumentId=' + this.ContentDocumentLink.ContentDocumentId);
                //show success message
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Salesforce File created with Signature',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                //show error message
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating Salesforce File record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
            
    }

    //clear the signature from canvas
    handleClearClick(){
        ctx.clearRect(0, 0, canvasElement.width, canvasElement.height);          
    }

    searchCoordinatesForEvent(requestedEvent, event){
        //event.preventDefault();
        if (requestedEvent === 'down') {
            this.setupCoordinate(event);           
            isDownFlag = true;
            isDotFlag = true;
            if (isDotFlag) {
                this.drawDot();
                isDotFlag = false;
            }
        }
        if (requestedEvent === 'up' || requestedEvent === "out") {
            isDownFlag = false;
        }
        if (requestedEvent === 'move') {
            if (isDownFlag) {
                this.setupCoordinate(event);
                this.redraw();
            }
        }
    }

    //This method is primary called from mouse down & move to setup cordinates.
    setupCoordinate(eventParam){
        //get size of an element and its position relative to the viewport 
        //using getBoundingClientRect which returns left, top, right, bottom, x, y, width, height.
        const clientRect = canvasElement.getBoundingClientRect();
        prevX = currX;
        prevY = currY;
        currX = eventParam.clientX -  clientRect.left;
        currY = eventParam.clientY - clientRect.top;
    }

    //For every mouse move based on the coordinates line to redrawn
    redraw() {
        ctx.beginPath();
        ctx.moveTo(prevX, prevY);
        ctx.lineTo(currX, currY);
        ctx.strokeStyle = x; //sets the color, gradient and pattern of stroke
        ctx.lineWidth = y;        
        ctx.closePath(); //create a path from current point to starting point
        ctx.stroke(); //draws the path
    }
    
    //this draws the dot
    drawDot(){
        ctx.beginPath();
        ctx.fillStyle = x; //blue color
        ctx.fillRect(currX, currY, y, y); //fill rectrangle with coordinates
        ctx.closePath();
    }


    
    
    /*handleTouchStart(event) {
        //event.preventDefault();
        if (event.touches.length === 1) {
            const currentX = event.touches[0].clientX - canvasElement.getBoundingClientRect().left;
            const currentY = event.touches[0].clientY - canvasElement.getBoundingClientRect().top;
            this.startDrawing(currentX, currentY);
        }
    }

    handleTouchMove(event) {
        //event.preventDefault();
        if (isDrawing && event.touches.length === 1) {
            const currentTime = Date.now();
            if (currentTime - lastUpdateTime > minTimeBetweenDraws) {
                lastUpdateTime = currentTime;
                const currentX = event.touches[0].clientX - canvasElement.getBoundingClientRect().left;
                const currentY = event.touches[0].clientY - canvasElement.getBoundingClientRect().top;
                this.continueDrawing(currentX, currentY);
            }
        }
    }*/

    /*handleTouchMove(event) {
        //event.preventDefault();
        if (isDrawing && event.touches.length === 1) {
            const currentX = event.touches[0].clientX - canvasElement.getBoundingClientRect().left;
            const currentY = event.touches[0].clientY - canvasElement.getBoundingClientRect().top;
            this.continueDrawing(currentX, currentY);
        }
    }*/

    /*handleTouchEnd(event) {
        //event.preventDefault();
        if (isDrawing) {
            this.stopDrawing();
        }
    }

    startDrawing(x, y) {
        isDrawing = true;
        signaturePoints.push({ x, y });
        ctx.beginPath();
        ctx.moveTo(x, y);
    }

    continueDrawing(x, y) {
        signaturePoints.push({ x, y });
        const lastPoint = signaturePoints[signaturePoints.length - 2];
        ctx.quadraticCurveTo(
            lastPoint.x,
            lastPoint.y,
            (x + lastPoint.x) / 2,
            (y + lastPoint.y) / 2
        );
        ctx.stroke();
    }

    stopDrawing() {
        isDrawing = false;
        ctx.closePath();
    }*/

    handleTouchStart(event) {
       // event.preventDefault();
        if (event.touches.length === 1) {
            const currentX = event.touches[0].clientX - canvasElement.getBoundingClientRect().left;
            const currentY = event.touches[0].clientY - canvasElement.getBoundingClientRect().top;
            this.startDrawing(currentX, currentY);
        }
    }

    handleTouchMove(event) {
       // event.preventDefault();
        if (isDrawing && event.touches.length === 1) {
            const currentX = event.touches[0].clientX - canvasElement.getBoundingClientRect().left;
            const currentY = event.touches[0].clientY - canvasElement.getBoundingClientRect().top;
            this.continueDrawing(currentX, currentY);
        }
    }

    handleTouchEnd(event) {
        //event.preventDefault();
        if (isDrawing) {
            this.stopDrawing();
        }
    }

    startDrawing(x, y) {
        isDrawing = true;
        signaturePoints.push({ x, y });
        ctx.beginPath();
        ctx.moveTo(x, y);
    }

    continueDrawing(x, y) {
       /* signaturePoints.push({ x, y });
        const i = signaturePoints.length - 1;
        const x0 = signaturePoints[i - 1].x;
        const y0 = signaturePoints[i - 1].y;
        const x1 = x;
        const y1 = y;
        const xc = (x0 + x1) / 2;
        const yc = (y0 + y1) / 2;
        ctx.quadraticCurveTo(x0, y0, xc, yc);
        ctx.stroke();*/

        const i = signaturePoints.length - 1;
        const prevX = signaturePoints[i].x;
        const prevY = signaturePoints[i].y;

        // Calculate the distance between current and previous points
        const distance = Math.sqrt(Math.pow(x - prevX, 2) + Math.pow(y - prevY, 2));

        // Adjust the curvature based on distance
        const curveFactor = Math.min(0.1, 1 / distance);

        // Calculate control points for quadratic Bezier curve
        const controlX = (prevX + x) / 2 + (y - prevY) * curveFactor;
        const controlY = (prevY + y) / 2 + (x - prevX) * curveFactor;

        ctx.quadraticCurveTo(prevX, prevY, controlX, controlY);
        ctx.stroke();

        // Store the current point
        signaturePoints.push({ x, y });

    }

    stopDrawing() {
        isDrawing = false;
        ctx.closePath();
    }

}