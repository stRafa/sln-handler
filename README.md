A bash script that handles sln project references.

Put the script on the folder you want to utilize sln handler.

# Case 1:
```
./sln-handler.sh
```
To add all projects to the sln on the same folder as the script.

# Case 2:
```
./sln-handler.sh -r 
```
OR

```
./sln-handler.sh --reset 
```
To delete the current sln and recreate it with all the projects dependencies

# Case 3:
```
./sln-handler.sh -n YourSolutionName
```
 OR
```
./sln-handler.sh --name YourSolutionName 
```
To create a new sln with the specified name and with all the project dependencies
 
