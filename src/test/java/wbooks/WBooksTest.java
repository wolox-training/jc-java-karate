package wbooks;

import com.intuit.karate.junit5.Karate;

class WBooksTest {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

}
