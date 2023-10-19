package UML.player;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class MediaFile implements Media {

    private String name;
    private String duration;
    private boolean isPlaying=false;

    @Override
    public String play() {
        this.setPlaying(true);
        return this.getInfo()+" <--Playing Now!";
    }

    public String stop(){
        this.setPlaying(false);
        return this.getInfo()+" <-- Is Stoped !";
    }

    @Override
    public String getInfo() {
        return this.getName()+" :"+this.getDuration();
    }



}
