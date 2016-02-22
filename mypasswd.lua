--�û�ͨ���û�����½���û���Ϊmd5����
--�û�����Ϊ�����ļ��ļ�����Կ��ʹ��AES�����㷨
require("aeslua");

--md5�����㷨
function md5_sumhexa(k)
	local md5_core = require "md5.core"
	k = md5_core.sum(k)
	return (string.gsub(k, ".",
		function (c)
			return string.format("%02x", string.byte(c))
		end
		)
	)
end
--���ܣ���ԿΪname
function decrypt_text(text)
	local plain = aeslua.decrypt(name, text);
	if (plain == nil) then
		print("Invalid password.");
	else
		return plain;
	end
end

--���ܣ���ԿΪname
function encrypt_text(text)
	local cipher = aeslua.encrypt(name, text);
	return cipher;
end


--��������
function add_passwd(pwd)
	local plain = get_plain()
	local file = io.open(filename, "w")
	file:write( encrypt_text(plain..pwd.."\n") )
	file:close()
end

--��ȡ����
function get_plain()
	local file = io.open(filename, "r");
	if (file == nil) then
		return ""
	else
		local cipher = file:read("*all");
		file:close()
		return decrypt_text(cipher)
	end
end

--չʾ����
function display_plain()
	local file = assert(io.open(filename, "r"));
	local cipher = file:read("*all");
	local plain = decrypt_text(cipher)
	print ("--------plain------")
	print (plain)
	print ("-------------------")
	file:close()
end

filename = "mypasswd.txt"
name=""
while(1)
do
	if( md5_sumhexa(name) ~= "64ac7f175154df332a06764bd1ae42b0" ) then
		print("login name:")
		name = io.read()
		print ("Your name is "..name)--wanglibao
	else
		print("welcome master\n1:add_passwd\n2:display_passwd\n3:quit")
		cmd = io.read()
		if(cmd=="1") then
			print("input your password")
			mypasswd = io.read()
			add_passwd(mypasswd)
		elseif(cmd=="2") then
			display_plain()
		elseif(cmd=="3") then
			break
		else
			print("no cmd")
		end
	end
end
io.read()


