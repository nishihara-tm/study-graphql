#!/bin/bash
CREATED_AT=$(curl --header "PRIVATE-TOKEN: glpat-uuCA22UnzMVNRxr65GRy" "https://gitlab.com/api/v4/projects/39305723/merge_requests/20/notes" | jq -r '.[-1].created_at')
ID=$(curl --header "PRIVATE-TOKEN: glpat-uuCA22UnzMVNRxr65GRy" "https://gitlab.com/api/v4/projects/39305723/merge_requests/20/notes" | jq -r '.[-1].id')
BODY=$(echo $1)

echo $BODY
echo $ID
echo $CREATED_AT

if [[ $CREATED_AT =~ 2000-01-01 ]]; then
  curl --header "PRIVATE-TOKEN: glpat-uuCA22UnzMVNRxr65GRy" --header "Content-Type: application/json" --request PUT -d '{"body": "'"$BODY"'"}' "https://gitlab.com/api/v4/projects/39305723/merge_requests/20/notes/$ID"
  echo "comment renewed"
else
  curl --header "PRIVATE-TOKEN: glpat-uuCA22UnzMVNRxr65GRy" --header "Content-Type: application/json" --request POST -d '{"body": "'"$BODY"'", "created_at": "2000-01-01"}' "https://gitlab.com/api/v4/projects/39305723/merge_requests/20/notes"
  echo "add new comment"
fi