import 'package:flutter/material.dart';
import 'package:witchle/app/app_colors.dart';
import 'package:witchle/game/data/word_list.dart';
import 'package:witchle/game/witchle.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';

enum GameStatus {playing, submitting, lost, won}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Properties
  GameStatus _gameStatus = GameStatus.playing;

  int numLetters = 5,
    numGuesses = 6,
    _currentWordIndex = 0;

  Word? get _currentWord =>
    _currentWordIndex < _board.length ? _board[_currentWordIndex] : null;

  Word _solution = Word.fromString(
    fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
  );

  //late List<Word> _board;
  final List<Word> _board = List.generate( 
    6,
    (_) => Word(letters: List.generate(5, (_) => Letter.empty()))
  );

  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
    6, 
    (_) => List.generate(5, (_) => GlobalKey<FlipCardState>()),
    );

  final Set<Letter> _keyboardLetters = {};

  // Methods
  void _onKeyTapped(String val){
    if(_gameStatus == GameStatus.playing){
      setState(() => _currentWord?.addLetter(val));
    }
  }
  
  void _onDeleteTapped(){
    if(_gameStatus == GameStatus.playing){
      setState(() => _currentWord?.removeLetter);
    }
  }
  
  Future<void> _onEnterTapped() async { // Async for flipcards to work
    if(_gameStatus == GameStatus.playing // Is playing
      && _currentWord != null 
      && !_currentWord!.letters.contains(Letter.empty()) // All spaces are filled
    ){
      _gameStatus = GameStatus.submitting;

      for(var i = 0; i < _currentWord!.letters.length; i++){
        final currentWordLetter = _currentWord!.letters[i];
        final currentSolutionLetter = _solution.letters[i];

        setState((){
          if(currentWordLetter == currentSolutionLetter) {
            _currentWord!.letters[i] = currentWordLetter.copyWith(status: LetterStatus.correct);
          } else if (_solution.letters.contains(currentWordLetter)) {
            _currentWord!.letters[i] = currentWordLetter.copyWith(status: LetterStatus.inWord);
          } else {
            _currentWord!.letters[i] = currentWordLetter.copyWith(status: LetterStatus.notInWord);
          }
          }
        );

        final letter = _keyboardLetters.firstWhere(
          (e) => e.val == currentWordLetter.val,
          orElse: () => Letter.empty()
        );
        if (letter.status != LetterStatus.correct){
          _keyboardLetters.removeWhere((e) => e.val == currentWordLetter.val);
          _keyboardLetters.add(_currentWord!.letters[i]);
        }

        await Future.delayed(
          const Duration(milliseconds: 150),
          () => _flipCardKeys[_currentWordIndex][i].currentState?.toggleCard(),
        );
      }

      _checkIfWinOrLoss();
    }
  }

  void _checkIfWinOrLoss(){
    // The word is the same as the solution
    if (_currentWord!.wordString == _solution.wordString){
      _gameStatus = GameStatus.won; // Win status

      // Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          duration: const Duration(days: 1),
          backgroundColor: correctColor,
          content: const Text(
            '¡Has acertado!',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          // Button
          action: SnackBarAction(
            onPressed: _restart,
            textColor: Colors.white,
            label: 'New Game'
          )
        )
      );
    } else if (_currentWordIndex + 1 >= _board.length){
      _gameStatus = GameStatus.lost;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          duration: const Duration(days: 1),
          backgroundColor: correctColor,
          content: Text(
            '¡Has fallado! Solución: ${_solution.wordString}',
            style: const TextStyle(
              color: Colors.white
            ),
          ),
          action: SnackBarAction(
            onPressed: _restart,
            textColor: Colors.white,
            label: 'New Game'
          )
        )
      );
    } else {
      _gameStatus = GameStatus.playing;
    }

    // Next letters will appear in next space
    _currentWordIndex ++;
  }

  void _restart(){
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      _board..clear()..addAll(
        List.generate(
          numGuesses,
          (_) => Word(letters: List.generate(numLetters, (_) => Letter.empty())),
        ),
      );
      _solution = Word.fromString(
        fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
      );
      _flipCardKeys
      ..clear()
      ..addAll(
        List.generate(
          6,
          (_) => List.generate(5, (_)=> GlobalKey<FlipCardState>())
        ),
      );
      _keyboardLetters.clear();
    });
  }

  // void emptyBoard(){
  //   List.generate( // Creates spaces in list
  //     numGuesses,
  //     (_) => Word(letters: List.generate(numLetters, (_) => Letter.empty())),
  //   );
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   emptyBoard();
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'WITCHLE',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          )
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Board(board: _board, flipCardKeys: _flipCardKeys),
          const SizedBox(height: 80),
          Keyboard(
            onKeyTapped: _onKeyTapped,
            onDeleteTapped: _onDeleteTapped,
            onEnterTapped: _onEnterTapped,
            letters: _keyboardLetters,
          )
        ],
      )
    );
  }
}