function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  var config = {
    env: env
  }

  // use this when extra env data configuration is needed, adding the file with the info to classpath
  //    var data = read('classpath:env-' + env);
  //    var env_data = data[env];

  switch (env) {
    case 'dev':
        config.urlNodeJS = 'https://nodejs-qa-training.herokuapp.com';
        // customize
        break;
    case 'stage':
        // customize
        break;
    case 'prod':
        // customize
        break;
  }

  karate.log('karate running now tests on env:', env);

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);

  karate.configure('retry', { count: 3, interval: 30000 });

  // might set to false for tests with performance issues
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  return config;
}