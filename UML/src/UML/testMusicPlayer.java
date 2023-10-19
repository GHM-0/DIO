package UML;

import UML.player.MediaFile;
import UML.player.MusicPlayer;
import UML.player.PlayList;

public class testMusicPlayer {

    public static void main(String[] args) {

        var mp=new MusicPlayer();
        var mus1=new MediaFile("Never Work's for Me!","2:35",false);
        var mus2=new MediaFile("Good For Nothing","3:45",false);
        var mus3=new MediaFile("Take a Bow","2:30",false);
        var mus4=new MediaFile("In The end","3:12",false);
        var vid1=new  MediaFile("Vacancy witn the EX-ep3","34:00",false);

        var musicPL=new PlayList(mus1,mus2,mus3);

        mp.PlayFile(musicPL);
        mp.play();
        mp.pause();
        mp.PlayFile(mus4);
        mp.play();




    }
}
