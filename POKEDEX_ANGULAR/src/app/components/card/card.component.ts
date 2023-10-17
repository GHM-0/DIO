import { Component, Input, OnInit } from '@angular/core';
import { PokemonData } from 'src/app/models/pokemonData';
import { PokemonAPIService } from 'src/app/services/pokemon-api.service';

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})

export class CardComponent implements OnInit{
pokemon:PokemonData={
	id:0,
	name:"pokeball",
  types:[{
		slot: 0,
		type:{
			name:'normal',
			url:''
		}
	}],
	sprites:{front_default:'assets/img/pokebola.png'}
};

constructor(private service:PokemonAPIService ){}

ngOnInit():void{
	this.service.getPokemon("hypinus").subscribe({
		next:(res)=> {
			this.pokemon={
				id:res.id,
				name:res.name,
				types:res.types,
				sprites:res.sprites
			}
			/* console.log(res)*/
			console.log(this.pokemon);
		},
		error:(err)=>console.log(err)
	});
}

}
