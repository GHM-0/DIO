import { Component, Input} from '@angular/core';

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent{
@Input() cover: string='../../assets/img_placeholder.png';
@Input() type: string='Exclusive';
@Input() name: string="GAME GENERIC NAME";
@Input() price: string="R$ 0.99";
@Input() consoles:any=['Mac','Linux','Windows'];
}
