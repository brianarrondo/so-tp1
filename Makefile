.POSIX:
.SUFFIXES:
.SUFFIXES: .o .cpp

CXX = g++
CXXFLAGS = -std=c++11
LDLIBS = -lpthread

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $<

BIN = test-1 test-2 test-3 test-4 test-5 test-6
OBJ = ConcurrentHashMap.o

all: $(BIN)

$(BIN): ListaAtomica.hpp

test-1: $(OBJ) test-1.cpp test.hpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test.hpp test-1.cpp $(LDLIBS)
	
test-1-run: test-1
	awk -f corpus.awk corpus | sort >corpus-post
	./test-1 | sort | diff -u - corpus-post
	rm -f corpus-post

test-2: $(OBJ) test-2.cpp test.hpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test.hpp test-2.cpp $(LDLIBS)

test-2-run: test-2
	awk -f corpus.awk corpus | sort >corpus-post
	for i in 0 1 2 3 4; do sed -n "$$((i * 500 + 1)),$$(((i + 1) * 500))p" corpus >corpus-"$$i"; done
	for i in 0 1 2 3 4; do \
		echo "Probando test-2 con parametro: "$$((i+1)); \
		./test-2 $$((i + 1)) | sort | diff -u - corpus-post; done
	rm -f corpus-post corpus-[0-4]

test-3: $(OBJ) test-3.cpp test.hpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test.hpp test-3.cpp $(LDLIBS)

test-3-run: test-3
	awk -f corpus.awk corpus | sort -nk 2 | tail -n 1 >corpus-max
	cat corpus-max
	for i in 0 1 2 3 4; do sed -n "$$((i * 500 + 1)),$$(((i + 1) * 500))p" corpus >corpus-"$$i"; done
	for i in 0 1 2 3 4; do for j in 0 1 2 3 4; do \
		echo "Probando test-3 con parametros: "$$((i+1))" "$$((j+1)); \
		./test-3 $$((i + 1)) $$((j + 1)) | diff -u - corpus-max; \
	done; done
	rm -f corpus-max corpus-[0-4]
	
test-4: $(OBJ) test-4.cpp test.hpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test.hpp test-4.cpp $(LDLIBS)

test-4-run: test-4
	awk -f corpus.awk corpus | sort -nk 2 | tail -n 1 >corpus-max
	cat corpus-max
	for i in 0 1 2 3 4; do sed -n "$$((i * 500 + 1)),$$(((i + 1) * 500))p" corpus >corpus-"$$i"; done
	for i in 0 1 2 3 4; do for j in 0 1 2 3 4; do \
		echo "Probando test-3 con parametros: "$$((i+1))" "$$((j+1)); \
		./test-4 $$((i + 1)) $$((j + 1)) | diff -u - corpus-max; \
	done; done
	rm -f corpus-max corpus-[0-4]

test-5: $(OBJ) test-5.cpp test.hpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test.hpp test-5.cpp $(LDLIBS)

test-5-run: test-5
	awk -f corpus.awk corpus | sort -nk 2 | tail -n 1 >corpus-max
	cat corpus-max
	for i in 0 1 2 3 4; do sed -n "$$((i * 500 + 1)),$$(((i + 1) * 500))p" corpus >corpus-"$$i"; done
	for i in 0 1 2 3 4; do for j in 0 1 2 3 4; do \
		echo "Probando test-3 con parametros: "$$((i+1))" "$$((j+1)); \
		./test-5 $$((i + 1)) $$((j + 1)) | diff -u - corpus-max; \
	done; done
	rm -f corpus-max corpus-[0-4]

test-6: $(OBJ) test-6.cpp test.hpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test.hpp test-6.cpp $(LDLIBS)

test-6-run: test-6
	awk -f corpus.awk corpus | sort -nk 2 | tail -n 1 >corpus-max
	cat corpus-max
	for i in 0 1 2 3 4; do sed -n "$$((i * 500 + 1)),$$(((i + 1) * 500))p" corpus >corpus-"$$i"; done
	for i in 0 1 2 3 4; do for j in 0 1 2 3 4; do \
		echo "Probando test-3 con parametros: "$$((i+1))" "$$((j+1)); \
		./test-6 $$((i + 1)) $$((j + 1)) | diff -u - corpus-max; \
	done; done
	rm -f corpus-max corpus-[0-4]

test-tiempo: $(OBJ) test_tiempos.cpp test_tiempo
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test_tiempos.cpp $(LDLIBS)

test-tiempo-run: test-tiempo
	python3 generador_corpus.py
	python3 correr_test_tiempo.py

test-correctitud: $(OBJ) test_count_words_2.cpp test_count_words_2
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test_count_words_2.cpp $(LDLIBS)

test-correctitud-run: test-correctitud
	python3 generador_corpus.py
	./test-correctitud

test-hashmap: $(OBJ) test_hashmap.cpp test_hashmap
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test_hashmap.cpp $(LDLIBS)

test-hashmap-run: test-hashmap
	./test-hashmap

test-lista: $(OBJ) test_lista.cpp test_lista
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ test_lista.cpp $(LDLIBS)

test-lista-run: test-lista
	./test-lista

clean:
	rm -f $(BIN) $(OBJ)
	rm -f corpus-*
