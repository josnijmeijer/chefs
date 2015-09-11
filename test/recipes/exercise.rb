directory  'temp' do
	owner 'administrator'
	group 'administrators'
	path  'c:\temp'
end
directory 'messages' do
	path 'c:\temp\messages'
end
file 'c:\temp\messages\settings.ini' do
		content 'greeting = hello robotoverlords'
end
