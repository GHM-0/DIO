const pokemonList = document.getElementById('pokemonList')
const loadMoreButton= document.getElementById('loadMoreButton') //replace By gesture

let maxRecords=151
const limit=10
let offset=0


function loadPokemons(offset, limit){
    pokeApi.getPokemons(offset, limit).then((pokemons=[])=>{
        const newHTML = pokemons.map(convertPokemonToli).join('')
        pokemonList.innerHTML += newHTML
    })
}

function convertPokemonToli(pokemon){
 return `<li class="pokemon ${pokemon.type}">
            <span class="number">#${pokemon.number}</span>
            <span class="name">${pokemon.name}</span> 
            <div class="detail">
                <ol class="types">
                 ${pokemon.types.map((type) => `<li class="type ${type}">${type}</li>`).join('')}
                </ol>
                <img src="${pokemon.image}" alt="${pokemon.name}">
            </div>
        </li>`
}

loadPokemons(offset, limit)

document.addEventListener('wheel', () => {
    offset += limit
    const qtdRecordsWithNexPage = offset + limit

    if (qtdRecordsWithNexPage >= maxRecords) {
        const newLimit = maxRecords - offset
        maxRecords+=offset
        loadPokemons(offset, newLimit)

        /* document.parentElement.removeChild(loadMoreButton) */
    } else {
        loadPokemons(offset, limit)
    }

    setTimeout(() => {
      }, 1000);
})