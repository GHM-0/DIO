
const pianoKeys=document.querySelectorAll('.key');
const volume=document.querySelector('.volume-slider');
const keysCheck=document.querySelector('.keys-check');

let audio = new Audio("src/assets/tunes/a.wav");
let mappedKeys=[];

document.addEventListener("keydown",(e)=>{
    if (mappedKeys.includes(e.key)){
        playTune(e.key); 
    }
}) ;

pianoKeys.forEach((key)=>{
    key.addEventListener("click",()=>playTune(key.dataset.key))
    mappedKeys.push(key.dataset.key);
});

const handlerVolume=(e)=>{
  audio.volume=e.target.value;
};

const showHideKeys=()=>{
    pianoKeys.forEach(key => key.classList.toggle('hide'))
}

const playTune = (key)=>{
    audio.src=`src/assets/tunes/${key}.wav`
    audio.play();

    const clickedKey=document.querySelector(`[data-key="${key}"]`)

    clickedKey.classList.add('active')
    setTimeout(()=>{clickedKey.classList.remove('active')},150);
}

/*Sempre declarar as funções antes de usar*/
keysCheck.addEventListener('click',showHideKeys)
volume.addEventListener("input",handlerVolume)



