<%
             const BASE_64_MAP_INIT = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" 
            dim nl 
            ' zero based arrays 
            dim Base64EncMap(63) 
            dim Base64DecMap(127) 

            '///////////////////////////////////////////////// 
            '/// must be called before using anything else 
            '/// 다른 작업이전에 먼저 호출해야하는 함수입니다. 
            '///////////////////////////////////////////////// 
            PUBLIC SUB initCodecs() 
                        ' init vars 
                        nl = "<P>" & chr(13) & chr(10) 
                        ' setup base 64 
                        dim max, idx 
                                    max = len(BASE_64_MAP_INIT) 
                        for idx = 0 to max - 1 
                                    ' one based string 
                                    Base64EncMap(idx) = mid(BASE_64_MAP_INIT, idx + 1, 1) 
                        next 
                        for idx = 0 to max - 1 
                                    Base64DecMap(ASC(Base64EncMap(idx))) = idx 
                        next 
            END SUB 



            '///////////////////////////////////////////////// 
            '/// encode base 64 encoded string 
            '/// Base64로 인코딩하는 함수입니다. 
            '///////////////////////////////////////////////// 
            PUBLIC FUNCTION base64Encode(plain) 

                        if len(plain) = 0 then 
                                    base64Encode = "" 
                                    exit function 
                        end if 

                        dim ret, ndx, by3, first, second, third 
                        by3 = (len(plain) \ 3) * 3 
                        ndx = 1 
                        do while ndx <= by3 
                                    first  = asc(mid(plain, ndx+0, 1)) 
                                    second = asc(mid(plain, ndx+1, 1)) 
                                    third  = asc(mid(plain, ndx+2, 1)) 
                                    ret = ret & Base64EncMap(  (first \ 4) AND 63 ) 
                                    ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) ) 
                                    ret = ret & Base64EncMap( ((second * 4) AND 60) + ((third \ 64) AND 3 ) ) 
                                    ret = ret & Base64EncMap( third AND 63) 
                                    ndx = ndx + 3 
                        loop 
                        ' check for stragglers 
                        if by3 < len(plain) then 
                                    first  = asc(mid(plain, ndx+0, 1)) 
                                    ret = ret & Base64EncMap(  (first \ 4) AND 63 ) 
                                    if (len(plain) MOD 3 ) = 2 then 
                                                second = asc(mid(plain, ndx+1, 1)) 
                                                ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) ) 
                                                ret = ret & Base64EncMap( ((second * 4) AND 60) ) 
                                    else 
                                                ret = ret & Base64EncMap( (first * 16) AND 48) 
                                                ret = ret & "=" 
                                    end if 
                                    ret = ret & "=" 
                        end if 
                        base64Encode = ret 
            END FUNCTION 



            '///////////////////////////////////////////////// 
            '/// decode base 64 encoded string 
            '/// Base64로 디코딩하는 함수 입니다. 
            '///////////////////////////////////////////////// 
            PUBLIC FUNCTION base64Decode(scrambled) 

                        if len(scrambled) = 0 then 
                                    base64Decode = "" 
                                    exit function 
                        end if 

                        ' ignore padding 
                        dim realLen 
                        realLen = len(scrambled) 
                        do while mid(scrambled, realLen, 1) = "=" 
                                    realLen = realLen - 1 
                        loop 
                        dim ret, ndx, by4, first, second, third, fourth 
                        ret = "" 
                        by4 = (realLen \ 4) * 4 
                        ndx = 1 
                        do while ndx <= by4 
                                    first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1))) 
                                    second = Base64DecMap(asc(mid(scrambled, ndx+1, 1))) 
                                    third  = Base64DecMap(asc(mid(scrambled, ndx+2, 1))) 
                                    fourth = Base64DecMap(asc(mid(scrambled, ndx+3, 1))) 
                                    ret = ret & chr( ((first * 4) AND 255) +  ((second \ 16) AND 3)) 
                                    ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15) ) 
                                    ret = ret & chr( ((third * 64) AND 255) +  (fourth AND 63) ) 
                                    ndx = ndx + 4 
                        loop 
                        ' check for stragglers, will be 2 or 3 characters 
                        if ndx < realLen then 
                                    first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1))) 
                                    second = Base64DecMap(asc(mid(scrambled, ndx+1, 1))) 
                                    ret = ret & chr( ((first * 4) AND 255) +  ((second \ 16) AND 3)) 
                                    if realLen MOD 4 = 3 then 
                                                third = Base64DecMap(asc(mid(scrambled,ndx+2,1))) 
                                                ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15) ) 
                                    end if 
                        end if 

                        base64Decode = ret 
    END FUNCTION 
	
	'// 한글을 포함 str의 byte 수 계산 (return str's byte value)
'----------------------------------------------------------------
	Function nLeft(str, strcut)
		Dim bytesize, nLeft_count
		bytesize = 0
		For nLeft_count = 1 to len(str)
			if asc(mid(str, nLeft_count, 1)) > 0 then
				bytesize = bytesize + 1
			Else
				bytesize = bytesize + 2
			End if
			if strcut >= bytesize then nLeft = nLeft & mid(str,nLeft_count, 1)    
		Next
		if len(str) > len(nLeft) then nLeft = left(nLeft, len(nLeft)-2) &".."
	End Function

	'회원명추출
	Function get_membername(db_conn,mb_code) 
		DBopen()
		Set nRs = Server.CreateObject("ADODB.RecordSet")
		sql = "select mem_id " _
		& "from mmember " _
		& "where mem_code = '" & mb_code& "' "
		Set nRs = conn.Execute(sql)
		if not nRs.Eof Then  
			get_membername = nRs(0)
		end if			 	 
		nRs.Close 
		DBclose()
	End Function 

	Function agencyManager(membercode) 
		DBopen()
		If membercode <> "" Then
			agency_member=CLng(Right(membercode,7))
			Set crs = Server.createObject("ADODB.RecordSet")
			csql = "select agency_code,agency_name from cagency where agency_hjumin = '"&agency_member&"'"
			'Response.write csql
			crs.Open csql, Conn, 1
			If not crs.Eof Then 					
				agency_code=crs("agency_code")

			End If
			crs.close
			DbClose()
		End If
		agencyManager=agency_code
	End Function

%>