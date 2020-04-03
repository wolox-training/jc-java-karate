package nodejs.flows.auth;

import com.intuit.karate.junit5.Karate;

class AuthRunner {

    @Karate.Test
    Karate testAuth() {
        return Karate.run("loginRole").relativeTo(getClass());
    }

}
