import { LightningElement } from 'lwc';

export default class BmiCalculator extends LightningElement {
     height = ''
     weight = ''
     bmiValue = ''
     result = ''

     //assign height and weight inputs
     inputHandler(event){
        const{name, value} = event.target
        if(name=="height"){
            this.height = value

        }
        if(name == "weight"){
            this.weight = value
        }
     }
     submitHandler(event){
        event.preventDefault()
        console.log(this.height)
        console.log(this.weight)
        this.calculateBMI()
     }
     calculateBMI(){

        //bmi calculation is weight in pounds / (height in inches * height in inches) * 703
        let bmi = Number(this.weight/(this.height*this.height))*703
        this.bmiValue = Number(bmi.toFixed(2))

        if(this.bmiValue < 18.5){
            this.result = "Underweight"
        }
        else if(this.bmiValue >= 18.5 && this.bmiValue < 25 ){
            this.result = "Healthy"
        }
        else if(this.bmiValue >= 25 && this.bmiValue < 30){
            this.result = "Overweight"
        }
        else{
            this.result = "Obese"
        }
        console.log("BMI value is: ", bmi)
        console.log("Result is: ", this.result)
      }
      recalculate(){
         
      }
}