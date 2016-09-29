def caesar_decrypt_guess(str)
    plaintext = ""

    # loop through all possible shifts
    for shift in 1..26

        # loop through the string
        str.each_char do |char|

            # get ascii code of character, convert to 1-26 scale
            charIndex = char.ord
            charIndex  = charIndex - 65

            # apply letter shift to character
            charIndex  = (charIndex + shift) % 26

            # convert index back to ascii code, then append to new string
            charIndex  = charIndex + 65
            plaintext << charIndex.chr

        end

        # print new string only if it contains "the"
        #if plaintext.include? "the"
            puts plaintext
        #end

        plaintext = ""

    end

    return plaintext
end

def caesar_decrypt(str, shift)
    plaintext = ""

    str.each_char do |char|

        # get ascii code of character, convert to 1-26 scale
        charIndex = char.ord
        charIndex  = charIndex - 65

        # apply letter shift to character
        charIndex  = (charIndex + shift) % 26

        # convert index back to ascii code, then append to new string
        charIndex  = charIndex + 65
        plaintext << charIndex.chr

    end

    puts plaintext

    return plaintext
end

def freq_analysis(str)
    freq = Hash.new
    letter = ""

    # initialize alphabet array with all zeroes
    for i in 0..25
        letter[0] = (i+65).chr
        freq[letter] = 0
    end

    # increment the entry of a letter by one if the string contains it
    str.each_char do |char|
        freq[char] = freq[char] + 1
    end

    # sort and print results
    freq = freq.sort_by {|_key, value| value}.reverse.to_h
    puts "Frequency Analysis Results: "
    freq.each do |key, value|
        puts key.to_s+"\t"+value.to_s
    end
end

# prints every "pos"th character in the string
def polyshift_extract(str, pos)
    ciphertext = ""
    shift_len = pos
    char_pos = 1

    str.each_char do |char|

        if (char_pos % shift_len == 1) then
            ciphertext << char
        end

        char_pos = char_pos + 1

    end

    return ciphertext
end

# splits the string into diagraphs
def diagraph_split(str)
    ciphertext = ""
    i = 0

    str.each_char do |char|

        ciphertext << char

        i = i + 1
        if(i%2 == 0) then
            ciphertext << " "
        end

    end

    return ciphertext
end

# analyzes frequency of n-grams
def ngram_analysis(str, n)
    # use a hash to store ngram - frequency mapping
    freq = Hash.new
    bigram = ""
    count = n-1
    i = 0

    # get the first ngram
    for i in 0..count
        bigram[i] = str[i]
    end

    freq[bigram] = 1

    str.each_char do |char|
        if i>=n then

            # bigram, trigram or quadrigram?
            bigram[0] = bigram[1]
            if n==2 then
                bigram[1] = char
            elsif n==3 then
                bigram[1] = bigram[2]
                bigram[2] = char
            elsif n==4 then
                bigram[1] = bigram[2]
                bigram[2] = bigram[3]
                bigram[3] = char
            end

            # updates values in the hash
            if freq.key?(bigram)==false then
                freq[bigram] = 1
            else 
                freq[bigram] = freq[bigram]+1
            end

        end
        i = i + 1
    end

    # sort and print
    freq = freq.sort_by {|_key, value| value}.reverse.to_h
    i=0
    puts "N-gram Analysis Results:"
    freq.each do |key, value|
        if value!=1 && i<20 then
            puts key.to_s+"\t"+value.to_s
        end
        i = i + 1
    end
end

cipher1 = "EMGHSVGHWMHCZVZVGQVBHZZGPELIWMHCZVUFNLFSMPDHHZKWASUNUGEIZUWMHCZVPZOCNGGIZLELEMGHWMHCZVUZMIPWLFAKEHLPKWASWGUZMIPWLFRGLXGTEWVNHZZVBVQUVQELREZGYMTSAIWMHCZVGBVPEIZUDHLXAPEMKWHDPZINLSCLQGZAKWASWGEWONHPPGWDNLUZOGHWHDGBVOHPBLUZZILZTKWMHCZVGBAKASRNINAXVBQYBLZPEMDGZYMPUZMZGBNZEQWGEQZVWGUZMIPWLFRDUNFNHZZGWGZRGMSZLEUCVFHZZVGBAPEMWGDHWDMPTVWGKILHMONEBLHWZPEMVXDGGQDVZIWMHCZVHDTDSFEMGKUCLMGHCBZGWGDELYAQPAZPUVHZHLZAEWWMHCZVSLHWWOUZMNEMZIZIKWXCPZCMUVENWGQZHPIZKWPBEMXEYKNKLMBVZMELPZUZHGHWHZQZZIZMFPDHLXVPHDGBELZAGBPAZPUZNLQZZIGSKPZRLSKYUBLZUNFEZLEMPWAQPAZPYKGSGKAZXMHNZIZIKWUBPZZCHPREUBUZMZELGEGMDUHWEPWMHCZVGBRDKQOGZMPZXAELALEMHFDPSLEZOGZPGBGKDRGOAPZRLSEHLOAKEMLXGOAQPZWKUZSASLZRGWZPEQLIPZKWNKUZZMGBAKEMZSKGUZSAQZONSZQTGHMPUZSAWMHCZVXTUBUZSAQZONHPPGKTZGSPZPHZSTHPLSPBEMXEMNVZZNVBOKZPCMUVENWGBDKAZLGSLNGKLGYGHGDWEPPELIHGUZGBEMHNLOBFOGGBVWHZZVUZGHOGVSITSAHGWMHCZVSZEMZRGWUAZLRQLNROHZMNHZZVEQKBYLMNGTGNKWCEOGZPQZZIGSKPZRPAKGPZZYVSSTHPUBUZZKMNEMZIZIQGOLGEOGUZSAEMZRRWGKGHBFOGUZMINOGHPZNZIOUPELVZEKZAUFVBMNHZZVGBAPZRLBZWWKKCSZPZPZFXZUEMOVZPQZZIGSGWZWWKSKGEIOFIPZPZFXZUEMOVZPZRROZIZMFPUZMZSLEHLRZUEMZRVWHZZVGBRDRWGOAPZRUZZIHNMZOGVGZGPFSVUBASXMOGPZUZMZKWFSHPUZELQOONHPPGNZLUIZFBHZZVQZHILHGQOGWMHCZVYLEIDAZGZVBGKZGMGHEIBLZPDSZLEMZVBDSVWGXTVQUZMZSGBINOGHAPZRLSUZHPREUZONHPPGLNGMAQEYGNDVGSWGZPGBKGZGZAQRWYEMGRZPQZZIGSRWKWKMFHELKOHNOLELALEMCVHDEQEFZLZMIZWGUZMZDHLXAPMKHPKWFZDRVZWMHCZVQGOLGEOGWMHCZVPMVHSKNGLYGEIOUZZIZMUNPEVFEMZIMNHZZVGBAPEMKERQLNSFEMZPEMGRVSNKUZUZMZUVHZGEGMDUHWEPYKZRUNGNGMGUHWWOTSWYLUEWSZRZDTFKNLGKLIPZDTGNSZGBUZEPKGVSKWATLPWMHCZVELUZYKPWGUVWHZZVNOHFZAWMBIKGHGZPEMAQKWUBUZNGDRQFWGHGXOZKHGHWMPQEDAZLEMEHWERQMPGHKYGKLIYKDBKGWPWMHCZVGBVWHZZVPMGDUNGEIWWPWMHCZVDWQBKYNTSVWEDUZRBLHWWKZPQZMESZSZUAEWVNHZZVYEVSZSSVLNPEHRNLFBHZZVZWENBFKEBLZWNELIXOSAQZZLHGZYULPLDWWGZPUZOLGHIZCBMHVMHPQXTQTSWGYBEMZIZIELEMQXHPIZQZONHPPGWMHCZVQNELZAELBFYGNGMVHNNGWMHCZVGHVDGRSZDTLPLUEWGBGKAZZRUNGLMGHGNZZSKGUZSAKLLPLUEWUZONKGWPGBAPEMHDUOGBKWFAHGKCNGFNHZZVUZNLWMHCZVZSKGCMUVENWGKBYLMNHZZVGQKYLIWMHCZVGTGEZRGMPZZSSYYBHZZVUZSAYKZRUNFPDSZLEMXMEGRGNLGBRVZPZDXEZPNGLXLSFPEHIZXMHNZIZIDGHNZGLZWGZPKGMNGELNPZGEGMGBIFEWINGQBLEMZSZMEHTQONSLZUEMOVZPQZOIOLUZHGPWGRWMHCZVGNDAELALEMUFVBNECBZRGVMHTPEMXMDGPWZVCBHZZVXOMWHZZVXONLSZIOGKTYEMWMLFAKASWGUZZIZMUNFNHZZVGHUFENVWHZZVXOSAYZNGTGWGXOMWHZZVXONLASIOCBPEIZPZUZMNEMZIZIGBAPEPAPZKLEUCUMDGVWHZZVZSKGQZMNHPPGGOLZBFVTGSBLWKHPDHVCNGEWKAZPSLBDZSGVLHVPDHZFEQZAZRPFSLPFNELERQMFHPPGGHQTFPPZUZONHZGBUVHZUZZGFZZKUOHGMNHZZVGBAKEMBDITMLPAZPUZMEZPNGNSUNFNVZZLMPYLLZNLRLELZGZSWGCMUVENWGWMHCZVVTLZQUGHWYEWELINGMVQUZELRLFWHZZVPMLXAPZRUBUZMNEMZIZIZRVWZKUZYENEREASWGKYWUNLNMDTHPWGKWUZZIGSROOGZGGUIFMDOGSTSLMPXMHNZIMNHZZVXTLSPBSZNZKMWGEQYZZGBIKZEMGOLZVHELOGPZINUAKGMPUZMZ"
freq_analysis(cipher1)
ngram_analysis(cipher1, 2)
ngram_analysis(cipher1, 3)
ngram_analysis(cipher1, 4)

