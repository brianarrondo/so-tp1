#include <iostream>
#include <cstdlib>
#include <list>
#include "ConcurrentHashMap.cpp"

using namespace std;

int main(){
	// list <string> l = {"texto.txt", "texto-2.txt", "texto-3.txt"};
	ConcurrentHashMap map;
	// map = countWordsArbitraryThreads(2, l);

	map.addAndInc("mariano");
	map.addAndInc("mariano");
	map.addAndInc("brian");
	map.addAndInc("magali");
	map.addAndInc("perro");

	map.operator<<(cout);
	ConcurrentHashMap map2;
	map2 = map;
	cout<<endl;
	// map2 = map;
	map2.operator<<(cout);

	// auto keys = map.keys();
	// for (auto i = keys.begin(); i != keys.end(); ++i)
	// {
	// 	cout << *i << endl;
	// }

	// auto value = map.value("brian");
	// cout << "Valor de : " << value << endl;

	// auto aux = maximumTwo(2, 3, l);
	// cout << "maximo ====> " << aux.first << " " << aux.second << endl;
	return 0;
}