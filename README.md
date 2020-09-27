# Video_Conference

N.B This is an academic assignment. Implemented using Agora.io API.


![WhatsApp Image 2020-09-27 at 8 49 38 PM](https://user-images.githubusercontent.com/34795471/94368084-29570d80-0104-11eb-81f2-80be0c972013.jpeg)

## Implemented Features:  
{including registration and Login}  

### Client-Side:  
**UI-**
1. Lobby(one to one)  
2. Add Contacts  
3. Invite Code  
4. Video call //Using agora.io API  

**Logic-**
1. Firebase CRUD //partial
2. HTTP POST request
3. Data Persistence 

### Server-Side(microservice):  
1. Generate User ID  
2. Generate Channel ID //to initiate Video Calls.  
3. Generate Invite  
3. Add User to Database[given(email, password), insert invite]   
4. Add contacts to User Database[given(invite), insert Channel ID]  

### Tests:  
1. Firebase Authentication 
2. Firestore Data Management  
3. HTTP Request //this test is used heavily to validate microservices functions in conjunction with POSTMAN  
4. Widget test  

## To be Implemented features:
1. Profile
2. Contact Search
3. File Share (on Process)
4. Chat
5. Notification and alerts (call alert on Process)
