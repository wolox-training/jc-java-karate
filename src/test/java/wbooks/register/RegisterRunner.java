package wbooks.register;

import com.intuit.karate.junit5.Karate;

class RegisterRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("register").relativeTo(getClass());
    }

}
