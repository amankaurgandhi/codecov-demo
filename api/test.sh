set -x 
RUNWHILE="True"
while [ $RUNWHILE == "True" ]
do
RESULT="$(aws stepfunctions describe-execution --execution-arn "arn:aws:states:us-east-1:573626210569:execution:TestGitHUbActions:ed24be44-df06-4ce6-8fe1-b2d09ab8960d" --query 'status' --output text)"
echo "::set-output name=currentresult::$RESULT"
if [[ $RESULT == "RUNNING" ]]
then
sleep 120
else
RUNWHILE="False"
fi
done
echo "::set-output name=finalresult::$RESULT"