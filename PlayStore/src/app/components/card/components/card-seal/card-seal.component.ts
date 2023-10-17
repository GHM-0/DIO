import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-card-seal',
  templateUrl: './card-seal.component.html',
  styleUrls: ['./card-seal.component.css']
})
export class CardSealComponent {
@Input() type: string='Exclusive';

}
