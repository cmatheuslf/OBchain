  //sha256 testa se hash foi feito ok

  module()
  function logic sha256_test(input block_content content_to_validate);
    return 1;
  endfunction
  
  //validação
    function logic validation(input block_content content_to_validate);
      if(content_to_validate.previous_hash_block == last_hash_valid)
        begin
          return sha256_test(content_to_validate) ? 1 : 0;
        end
      else return 0;
    endfunction