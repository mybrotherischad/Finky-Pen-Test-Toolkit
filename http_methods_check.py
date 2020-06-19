import http.client

print("** Ths program returns a list of metods if OPTIONS is enabled ** \n")

host = input("Insert the host/IP (default:localhost): ")
port = input("Insert the port (default: 80): ")

if (host == ""):
    host = "localhost"

if (port == ""):
    port = 80

try:
    connection = http.client.HTTPConnection(host,port)
    connection.request('OPTIONS','/')
    response = connection.getresponse()
    print("Enabled methods are: ",response.getheader('allow'))
    connection.close()

except ConnectionRefusedError:
    print("Connection Failed")
