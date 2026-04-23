# Show the full redirect chain with headers
curl -skI http://pgweb.kbai.ttmtech.com/

# Or verbose to see everything
curl -skv http://pgweb.kbai.ttmtech.com/ 2>&1 | grep -E '^< HTTP|^< Location|^> GET' | head -10

# And follow redirects to see the chain
curl -skIL http://pgweb.kbai.ttmtech.com/ 2>&1 | grep -E '^HTTP|^Location' | head
