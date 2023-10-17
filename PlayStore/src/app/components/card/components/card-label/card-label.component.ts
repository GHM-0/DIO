import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-card-label',
  templateUrl: './card-label.component.html',
  styleUrls: ['./card-label.component.css']
})
export class CardLabelComponent {
@Input() name: string="GAME GENERIC NAME";
@Input() price: string="R$ 0.99";

//How to pass arrays from componets to it's subcomponents
@Input() consoles:string[]=['Mac','Linux','Windows'];
}
