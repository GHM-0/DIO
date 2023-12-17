const state={
    view:{
        squares:document.querySelectorAll(".square"),
        enemy:document.querySelector(".enemy"),
        timeLeft:document.querySelector("#time-left"),
        score:document.querySelector("#score"),  
    },
    values:{
        hitPosition:0,
        result:0,
        currentTime:60,
    },
    actions:{
        countDownTimerId:setInterval(countDown,1000),
        timerId:setInterval(randomSquare,1000),
    }
};

function randomSquare(){
    state.view.squares.forEach((square)=>{
        square.classList.remove('enemy');
    });

    let randomNumber=Math.floor(Math.random()*9);
    let randomSquare=state.view.squares[randomNumber];
    randomSquare.classList.add('enemy');
    state.values.hitPosition=randomSquare.id;
    
}

 function countDown(){
    state.values.currentTime--;
    state.view.timeLeft.textContent=state.values.currentTime;

    if (state.values.currentTime<=0){
        clearInterval(state.actions.countDownTimerId);
        clearInterval(state.actions.timerId);

        alert('Fim de Jogo sua pontuação:'+state.values.result);
    }
}

function addListenerHitbox(){
    state.view.squares.forEach((square)=>{
        square.addEventListener("mousedown",()=>{
            if(square.id===state.values.hitPosition){
                state.values.result++;
                state.view.score.textContent= state.values.result;
                state.values.hitPosition=null;
                playSound();
            }else{
                
            }
        });
    });
}

function playSound(){
    let audio =new Audio('../src/assets/audio/hit.mp3');
    audio.volume=0.2;
    audio.play();
}
function main(){
    addListenerHitbox(); 
}

main();