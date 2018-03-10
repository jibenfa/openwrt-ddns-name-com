# openwrt-ddns-name-com
using shell script to refresh dns with name.com v4 api on openwrt router
此脚本用于在openwrt路由上使用shell脚本更新dns(使用name.com v4 api)。

前提：  
1.域名必须是由name.com购买的，并且生成一个生产的Token。  
2.登陆账户必须没有开启二次验证。  
3.路由上需要安装curl和ca-certificates和ca-bundle,以便解析https。  
4.首次需要手动添加一次域名，以便获取ID号码，例如为www.examle.com添加第一个dns记录：  

  curl -u 'YOUR_USER_NAME:YOUR_API_TOKEN' 'https://api.name.com/v4/domains/example.com/records' -X POST --data '{"host":"www","type":"A","answer":"YOUR_IP","ttl":300}'  
  
从返回的json中获取id，并记录下来：  
{  
    "id": 12345,  
    "domainName": "example.org",  
    "host": "www",  
    "fqdn": "www.example.org",  
    "type": "A",  
    "answer": "10.0.0.1",  
    "ttl": 300  
}  

