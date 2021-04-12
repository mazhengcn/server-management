# Server-Management

Useful tools and scripts for managing zylab servers.

# For Admin

To add a user, copy ```add-user.sh``` to any directory on the server and run:

```sudo bash add-user.sh "username" "password"``` 

Make sure to delete this record in ```~/.bash_history``` or change the password for security.

To delet a user, run

``` sudo bash delete-user.sh "username"```

if you want to keep the user's data volume add "true" option at the end.
