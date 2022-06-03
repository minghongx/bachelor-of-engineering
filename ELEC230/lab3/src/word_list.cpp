// “boilerplate” left out
    vector<string> words;
    for (string s; cin>>s && s != "quit"; )  // && means AND
        words.push_back(s);
    sort(words.begin(),words.end());  // sort the words we read
    for (string s : words)
        cout << s << '\n';

/*
read a bunch of strings into a vector of strings, sort
them into lexicographical order (alphabetical order),
and print the strings from the vector to see what we have.
*/
