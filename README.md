# Tic Tac Toe

A simple command line implementation of the classic game Tic Tac Toe written in Ruby.

## Getting Started

### Prerequisites

- Ruby 2.7.4 or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/greenplastic90/Tick_Tac_Toe_Ruby.git
   ```
2. Navigate into the project directory:
   ```bash
   cd Tick_Tac_Toe_Ruby
   ```
3. Run the game:
   ```bash
   ruby run.rb
   ```

### How to Play

The game is played on a 3x3 board. Players take turns placing their symbol (X or O) in an empty cell on the board. The first player to get three of their symbols in a row (horizontally, vertically, or diagonally) wins the game. If all cells on the board are filled and no player has won, the game is a tie.

### Features

- Player names and symbols can be customized at the start of the game.
- The game board is displayed after each turn.
- Scores are kept for each player and displayed after each game.
- The game can be restarted or ended after each game.

### Code Structure

- `run.rb`: The entry point of the program.
- `game.rb`: Contains the main `Game` class, which is responsible for managing the game board, players, and game logic.
- `player.rb`: Contains the `Player` class, which represents a player in the game and is responsible for getting the player's name and symbol choice.
- `helper.rb`: Contains helper methods used by other classes.

### Built With

- [Ruby](https://www.ruby-lang.org/) - The programming language used.
