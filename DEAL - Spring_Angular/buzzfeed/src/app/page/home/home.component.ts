import { Component } from '@angular/core';
import { QuizzComponent } from "../../component/quizz/quizz.component";

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [QuizzComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {

}
