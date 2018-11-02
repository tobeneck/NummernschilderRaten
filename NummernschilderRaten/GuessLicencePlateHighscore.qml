import QtQuick 2.0

Item{
    id: guessLicencePlateHighscore

    function setNewUserQuestion(ansẃer1, answer2, answer3, answer4, rightAnswer, cityName1, cityName2, cityName3, cityName4){

        button1.text = ansẃer1
        button2.text = answer2
        button3.text = answer3
        button4.text = answer4

        button1.enabled = true
        button2.enabled = true
        button3.enabled = true
        button4.enabled = true

        button1.rightAnswer = false
        button2.rightAnswer = false
        button3.rightAnswer = false
        button4.rightAnswer = false

        button1.cityName = cityName1
        button2.cityName = cityName2
        button3.cityName = cityName3
        button4.cityName = cityName4

        switch(rightAnswer){
            case 1:
                button1.rightAnswer = true
                questionCityName.text = cityName1
                break;
            case 2:
                button2.rightAnswer = true
                questionCityName.text = cityName2
                break;
            case 3:
                button3.rightAnswer = true
                questionCityName.text = cityName3
                break;
            case 4:
                button4.rightAnswer = true
                questionCityName.text = cityName4
                break;
        }
    }


    Text{
        text: "highscore"
        anchors.fill: parent
    }
}

