package UML.player;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Arrays;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PlayList {

	private ArrayList<MediaFile> itens=new ArrayList<MediaFile>();
	private String name="Unknow";

	public void addItens(MediaFile m) {
		this.itens.add(m);
	}

	public void removeItens(MediaFile m) {
		if(this.itens.contains(m)){
			this.itens.remove(m);
		}
	}

	public void savePlayList(String name){
		this.setName(name);
		System.out.println("Saving This PlayList with Name "+this.getName());
	}

	public PlayList(MediaFile ... m){
		Arrays.stream(m).forEach(media -> {this.itens.add(media);});
	}

}
