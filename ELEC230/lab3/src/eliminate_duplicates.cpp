// Eliminate the duplicate words by copying only unique words:
#include <string>
#include <vector>
#include <iostream>

using namespace std;

int main() {  // fixme: not functioning
    vector <string> words;
    for (string s; cin >> s && s != "quit";)
        words.push_back(s);
    sort(words.begin(), words.end());
    vector <string> w2;
    if (!words.empty()) {  // note style { }
        w2.push_back(words[0]);
        for (int i = 1; i < words.size(); ++i)  // note: not a range-for
            if (words[i - 1] != words[i])
                w2.push_back(words[i]);
    }
    cout << "found " << words.size() - w2.size() << " duplicates" << endl;
    for (string s: w2)
        cout << s << endl;
}
