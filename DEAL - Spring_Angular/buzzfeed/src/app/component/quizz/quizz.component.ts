import { Component, OnInit } from '@angular/core';
import quizz_questions from "../../../assets/data/quizz_questions.json";

@Component({
  selector: 'app-quizz',
  standalone: true,
  imports: [],
  templateUrl: './quizz.component.html',
  styleUrl: './quizz.component.css'
})
export class QuizzComponent implements OnInit {
  questionary:any;

  questionIndex:number=0;
  questionMaxIndex:number=0;
  

  title:string="The title is";

  questionSelected:any= { question: "The question is", options: ["The first Option is","The Second Option is"] };

  answers:string[]=[];
 


  finished:boolean=false;

  result:string="Undefined";

  constructor(){}

  ngOnInit(): void {

    if(quizz_questions){
      this.finished=false;

      this.questionary= quizz_questions;
      this.questionMaxIndex=this.questionary.questions.length;
      this.title=this.questionary.title;

      //this.questionSelected = this.questionary.questions[this.questionIndex]; 
      this.nextquestion();
    }
  }

  playerChoose(value:string){
    this.answers.push(value);
    //move to next question

    this.questionIndex++;
    this.nextquestion();
  }

  nextquestion(){
    if(this.questionIndex < this.questionMaxIndex){
      this.questionSelected = this.questionary.questions[this.questionIndex]; 
    }else{
      this.finished = true;
      this.calculateAnswer();
    }
  }

  // Ineficiente e fácil
  // calculateAnswer():void{

  // const opcoes =  new Set(this.answers);
  // let mostFrequent:string="";
  // let maxCount=0;

  // opcoes.forEach( opcao =>{
  //                 //Agrupa elementos e conta
  //   const count = this.answers.filter(elemento => elemento === opcao).length;

  //   //Try reduce to key(unique element):value(count element)  


  //   if (count > maxCount) {
  //     maxCount = count;
  //     mostFrequent = opcao;
  //   }else if(count === maxCount && count>0){
  //      mostFrequent = "U";
  //   }
  // });


  // if(mostFrequent === 'A'){
  //   this.result="Heroi";
  // }else if(mostFrequent === 'B'){
  //   this.result="Vilão";
  // }else{
  //   this.result = "Do the test again!";
  // }    
  // }

  calculateAnswer():void{
    // alert(this.answers.join(', '));
      let mostFrequent:string="";
      let maxCount:number=0;

      const answersFrequency = this.answers.reduce(
        (countElement, element)=>{
          countElement[element] = (countElement[element] || 0)+1;
          return countElement
        },{} as {[key:string]:number}
      );
      
      for(const [key,value] of Object.entries(answersFrequency)){
        if (value > maxCount) {
          maxCount = value;
          mostFrequent = key;
        } else if (value === maxCount && value > 0) {
            mostFrequent = "U"; 
        }
      }

      if (mostFrequent != 'U') {
          this.result = this.questionary.results[mostFrequent];
      } else {
          this.result = "Do the test again!";
      }
      
  }



}
