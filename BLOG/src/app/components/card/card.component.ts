import { Component, OnInit,Input } from '@angular/core';

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class  CardComponent implements OnInit{

  @Input() id:string="0";
	@Input() author:string=`@Autor`;
	@Input() photoCover:string=`../../../assets/img_placeholder.png`;
	@Input() title:string=`CARD TITLE`;
	@Input() description:string=`CARD DESCRIPTION`;
	//Como não renderizar 1706 chars of Article.content.substring(0,1706)
	@Input() paragraph:string=`Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lorem magna, suscipit porta ultricies ut,
	tempor sit amet leo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris lorem ante, placerat
	ut elit ut, aliquam efficitur metus. Morbi volutpat malesuada fringilla. Nam ac ligula sit amet odio luctus
	congue nec eu neque. Donec varius eros massa, sit amet congue nisi consequat sit amet. Sed tristique consectetur
	tempus. Aenean eget pretium ligula. Aliquam erat volutpat. Vestibulum quis felis ligula. Maecenas ornare risus nibh,
	eget sollicitudin dolor maximus id. Etiam vestibulum pulvinar arcu vel pulvinar. Morbi ut molestie mauris.
	Fusce porttitor tellus ac mollis pulvinar. Cras nec ultrices quam.`;


	constructor(){}
	ngOnInit(): void {

	}

}
