package UML.player;

import java.util.Arrays;

public class MusicPlayer {

	private PlayList queue;
	private MediaFile playing=null;

	public void play() {

			this.queue.getItens().forEach(i ->{
				if (!i.isPlaying()){
					playing=i;
					System.out.println(i.play());
				}
			});
	}

	public void pause() {
		System.out.println(this.playing.getInfo()+" is stoped");
		this.playing.stop();
	}

	public void PlayFile(MediaFile ...m){
		this.queue=null;
		var unk=new PlayList();
		Arrays.stream(m).forEach( media ->{ unk.addItens(media);} );
		this.queue=unk;
		this.play();
	}

	public void PlayFile(PlayList p){
		this.queue=p;
	}

	public void exit() {
		System.out.println("Closing MediaPlayer!");
	}

}
