APP_NAME=app
APP_OUTPUT=output.txt
APP_INPUT=input.txt
ENDL='\n'
DELIM='-------------------------------------------'
if [ -f $APP_NAME ]
then
    echo 'Removing old binary...'
    rm app
fi
echo 'Building '$APP_NAME'...' 
c++ -std=c++11  main.cpp -o app
if [ -f $APP_NAME ]
then
    echo 'Running '$APP_NAME'...'
    ./$APP_NAME < $APP_INPUT > $APP_OUTPUT 
    echo $APP_NAME' stdout:'
    echo $DELIM$ENDL
    cat $APP_OUTPUT 
    echo $ENDL$DELIM
fi
