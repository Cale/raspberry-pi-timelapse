<?php

// Twitter library
require_once 'src/twitter.class.php';

function postToTwitter() {
        $consumerKey = "twitterapikeyshere";
        $consumerSecret = "twitterapikeyshere";
        $accessToken = "twitterapikeyshere";
        $accessTokenSecret = "twitterapikeyshere";


        $img = "/var/www/html/nashville.calemooth.com/public_html/nashville.jpg";

        $twitter = new Twitter($consumerKey, $consumerSecret, $accessToken, $accessTokenSecret);

        // Get weather data from OpenWeatherMap https://openweathermap.org/
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_URL, 'http://api.openweathermap.org/data/2.5/weather?zip=37127,us&units=imperial&APPID=yourkey');
        $result = curl_exec($ch);
        curl_close($ch);

        $obj = json_decode($result, true);

        // Temperature and current conditions
        $temp = round($obj['main']['temp']);
        $conditions = strtolower($obj['weather'][0]['main']);

        $tweet = $temp."° and ".$conditions." in Murfreesboro.";

        //Post to Twitter
        if ($conditions != "") {
                try {
                        $tweet = $twitter->send($tweet, $img); // you can add $imagePath or array of image paths as second argument

                } catch (TwitterException $e) {
                        echo 'Error: ' . $e->getMessage();
                }
        }

}

postToTwitter();

?>
