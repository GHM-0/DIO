// FIX
// const img = document.querySelector("img");
// img.setAttribute("draggable", false);

/*Dados*/
const state={
    score:{
        playerScore:0,
        computerScore:0
    }
};
const players={
    computer:"computer_cards",
    player:"player_cards"
}

/*views*/
const view={
    scoreBox:document.getElementById("score_points"),
    cardSprites:{
        avatar:document.getElementById("card-image"),
        name:document.getElementById("card-name"),
        type:document.getElementById("card-type")
    },
    fieldCards:{
        player:document.getElementById('player-card'),
        computer:document.getElementById('computer-card')
    },
    players:{
        playerBox:document.querySelector("#player_cards"),
        computerBox:document.querySelector("#computer_cards")
    }
};

const actions={
    button:document.getElementById("next-duel")
};

const pathImg="src/assets/icons/";
const cardData=[
{
    id:0,
    name:'Blue Eyes White Dragon',
    type:"Paper",
    img:`${pathImg}dragon.png`,
    WinOf:[1],
    LoseOf:[2]
},
{
    id:1,
    name:'Drak Magician',
    type:"Rock",
    img:`${pathImg}magician.png`,
    WinOf:[2],
    LoseOf:[0]
},
{
    id:2,
    name:'Exodia',
    type:"Scissors",
    img:`${pathImg}exodia.png`,
    WinOf:[0],
    LoseOf:[1]
}];

async function resetDuel(){
    view.cardSprites.avatar.style.display="none";
    view.cardSprites.name.innerText="Selecione";
    view.cardSprites.type.innerText="uma carta";
    actions.button.style.display="none";

    view.fieldCards.player.style.display="none";
    view.fieldCards.computer.style.display="none";
    
    main();
}

async function drawCards(cardNumbers,fieldSide){
    for (let i=0;i<cardNumbers;i++){
        const idCard= await getRandomCardId();
        const cardImage= await createCardImage(idCard,fieldSide);

        document.getElementById(fieldSide).appendChild(cardImage);
    }
}

async function getRandomCardId(){
  const randomIndex=Math.floor(Math.random() * cardData.length)
  return cardData[randomIndex].id;
}

async function createCardImage(idCard,fieldSide){
    const cardImage=document.createElement("img");
    cardImage.setAttribute("height","100px");
    cardImage.setAttribute("src",`${pathImg}card-back.png`);
    cardImage.setAttribute("data-id",idCard);
    cardImage.classList.add("card");
    cardImage.setAttribute("draggable", false);

    if(fieldSide===players.player){

        cardImage.addEventListener("mouseover",()=>{
            drawSelectCard(idCard);
        });

        cardImage.addEventListener("click",()=>{
            setCardsField(cardImage.getAttribute("data-id"));
        });
    }

return cardImage;
}

async function drawSelectCard(idCard){
    view.cardSprites.avatar.src= cardData[idCard].img;
    view.cardSprites.name.innerText=cardData[idCard].name;
    view.cardSprites.type.innerText="Attribute: "+cardData[idCard].type;
}

async function setCardsField(idCard){
    await removeAllCardsImages();
    
    let computerCardId= await getRandomCardId();

    view.fieldCards.player.style.display="block";
    view.fieldCards.computer.style.display="block";

    view.fieldCards.player.src=cardData[idCard].img;
    view.fieldCards.computer.src=cardData[computerCardId].img;

    let duelResult= await checkDuelResults(idCard,computerCardId);
    await updateScore();
    await drawButton(duelResult);
}

async function removeAllCardsImages(){
    let {playerBox,computerBox}=view.players;
    let compImgElements=computerBox.querySelectorAll("img");
    let userImgElements=playerBox.querySelectorAll("img");
    compImgElements.forEach((img)=>img.remove());
    userImgElements.forEach((img)=>img.remove());
}

async function checkDuelResults(idCard,computerCardId){
    let playerCard=cardData[idCard];
    let duelResults="draw";

    if (playerCard !== null){
        if(playerCard.LoseOf.includes(computerCardId)){
            duelResults="Lose";
            state.computerScore++;
        }
    
        if(playerCard.WinOf.includes(computerCardId)){
            duelResults="Win";
            state.score.playerScore++;
        }

        playAudio(duelResults);
    }
    
    return duelResults;
}

async function drawButton(text){
    actions.button.innerText=text;
    actions.button.style.display="block";
}

async function updateScore(){
     view.scoreBox.innerText=`Win : ${state.score.playerScore} | Lose: ${state.score.computerScore}`
}

async function playAudio(status){
    let audio= new Audio(`src/assets/audios/${status.toLocaleLowerCase()}.wav`);
    
    try {
        audio.play();
    } catch (error) {
        
    }

}

function main(){
    view.fieldCards.player.style.display="none";
    view.fieldCards.computer.style.display="none";

    drawCards(5,players.computer);
    drawCards(5,players.player);

    const bgm=document.getElementById("bgm");
    bgm.play();
}

main();