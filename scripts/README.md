# Server-Management

Useful tools and scripts for managing zylab servers.

# For Admin

To add a user, copy ```add-user.sh``` to any directory on the server and run:

```sudo bash add-user.sh "username" "password"``` 

If you want to have other initial size of the user's directories, add "xxG" (size of home, unit 'G') "xxG" (size of data, unit 'G') to the end.

To delete a user, run

``` sudo bash delete-user.sh "username"```

if you want to keep the user's data volume add "true" option at the end.
