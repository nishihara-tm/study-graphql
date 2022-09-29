#!/bin/bash
CREATED_AT=$(curl --header "PRIVATE-TOKEN: glpat-uuCA22UnzMVNRxr65GRy" "https://gitlab.com/api/v4/projects/39305723/merge_requests/20/notes" | jq -r '.[-1].created_at')
ID=$(curl --header "PRIVATE-TOKEN: glpat-uuCA22UnzMVNRxr65GRy" "https://gitlab.com/api/v4/projects/39305723/merge_requests/20/notes" | jq -r '.[-1].id')
BODY=$(cat body.txt | sed -z "s/\n/\n\n/g")

echo $BODY
echo $ID
echo $CREATED_AT

if [[ $CREATED_AT =~ 2000-01-01 ]]; then
  jq -n --arg body "$BODY" '{"body": $body}' |
  curl --header "PRIVATE-TOKEN: glpat-uuCA22UnzMVNRxr65GRy" --header "Content-Type: application/json" --request PUT -d@- "https://gitlab.com/api/v4/projects/39305723/merge_requests/20/notes/$ID"
  echo "comment renewed"
else
  jq -n --arg body "$BODY" '{"body": $body, "created_at": "2000-01-01"}' |
  curl --header "PRIVATE-TOKEN: glpat-uuCA22UnzMVNRxr65GRy" --header "Content-Type: application/json" --request POST -d@- "https://gitlab.com/api/v4/projects/39305723/merge_requests/20/notes"
  echo "add new comment"
fi