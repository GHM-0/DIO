import {HttpClient} from '@angular/common/http';
import {Injectable} from '@angular/core';
import { Observable } from 'rxjs';
import {environment} from 'src/environments/environment';
import {PokemonData} from 'src/app/models/pokemonData'

@Injectable({
  providedIn: 'root'
})
export class PokemonAPIService {
 	private baseURL:string='';
	private pokeData:PokemonData|any;

  constructor(private http:HttpClient) {
		this.baseURL=environment.pokeAPI;
	 }


	getPokemon(name:string):Observable<PokemonData>{

		this.pokeData=this.http.get<PokemonData>(`${this.baseURL}${name}`);
		return this.pokeData;
	}
}
