const emojis=[
    '😷','😷',
    '🤑','🤑',
    '🤩','🤩',
    '🤮','🤮',
    '🤬','🤬',
    '🤔','🤔',
    '🍆','🍆',
    '🍘','🍘'
];

let openCards=[];

let shuffleEmojis= emojis.sort(
    ()=>(Math.random() > 0.5) ? 2 : -1);

for(let i=0;i<emojis.length;i++){
    let box = document.createElement("div");
    box.className="item"
    box.innerHTML=shuffleEmojis[i];
    box.onclick = handlerClick;
    document.querySelector(".game").appendChild(box);
}

function handlerClick(){
    if (openCards.length<2){
        this.classList.add("openCard");
        openCards.push(this);
    }

    if(openCards.length==2){
        setTimeout(checkMatch,500);
    }
}

function checkMatch(){
   if(openCards[0].innerHTML === openCards[1].innerHTML){
        openCards.forEach(element => {
                element.classList.add("matchCard")
            });
   }else{
    openCards.forEach(element => {
        element.classList.remove("openCard")
    });
   }
   openCards=[];
   
   if (document.querySelectorAll(".matchCard").length==emojis.length){
    alert("! Finished Game")
   }
}

