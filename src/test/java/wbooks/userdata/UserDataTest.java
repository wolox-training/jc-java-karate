package wbooks.userdata;

import com.intuit.karate.junit5.Karate;

class UserDataTest {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("userdata").relativeTo(getClass());
    }

}
