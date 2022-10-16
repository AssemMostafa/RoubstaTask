# Roubsta Task

# Intoduction
This is a brief description about Roubsta iOS programming task.

# Networking
The networking layer used in this project consists of 2 main parts

  - ApiConfig - a base url holder and error holder.
 
  - class Service - a Service that mange all data related to a specafic request (HTTP method, headers, response type etc), responsible for parsing the raw data it recieves and also it is responsible for converting Http errors and status codes to application specfic errors, represent an network operation on a specafic resource, the task is also responsible for parsing the json/data it recieves to the operation specfic data type.

# Application architecture
This application uses MVVM architecture with flow coordinators, The application has a 2 View models, the RepositoriesViewModel which is responsible for displaying a list of Repositories and the RepositoryProfileViewModel which is responsible for displaying a single Repository. 



# Created by
Ahmed Assem



