package nodejs.flows.albums;

import com.intuit.karate.junit5.Karate;

public class AlbumRunner {

    @Karate.Test
    Karate testUsers() { return Karate.run("albums").relativeTo(getClass()); }

}
