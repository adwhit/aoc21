#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int OFFSET = 1000;

void read_row(char* row_str, int* row) {
  sscanf(row_str, "%d %d %d %d %d", &row[0], &row[1], &row[2], &row[3], &row[4]);
}

int read_board(int* board) {
  for (int i=0; i<5; i++) {
    char* line = strtok(NULL, "\n");
    if (!line) {
      return -1;
    }
    read_row(line, &board[i * 5]);
  }
  return 1;
}

char* read_input() {
  FILE * f = fopen ("data/04", "rb");
  fseek (f, 0, SEEK_END);
  int length = ftell (f);
  fseek (f, 0, SEEK_SET);
  char* buffer = malloc (length);
  fread (buffer, 1, length, f);
  fclose (f);
  return buffer;
}

int mark_board(int* board, int value) {
  for (int i=0; i<5; i++) {
    for (int j=0; j<5; j++) {
      int loc = i * 5 + j;
      if (board[loc] == value) {
        board[loc] = -value - OFFSET;
        return 1;
      }
    }
  }
  return 0;
}

int is_line(int* board) {
  for (int i=0; i<5; i++) {
    int line = 1;
    int vert = 1;
    for (int j=0; j<5; j++) {
      int lloc = i * 5 + j;
      if (board[lloc] > 0) {
        line = 0;
      }

      int vloc = i + j * 5;
      if (board[vloc] > 0) {
        vert = 0;
      }
    }
    if (line)
      return 1;
    if (vert)
      return 1;
  }
  return 0;
}

int score_board(int* board, int winning_num) {
  int score = 0;
  for (int i=0; i<5; i++) {
    for (int j=0; j<5; j++) {
      int loc = i * 5 + j;
      if (board[loc] > 0) {
        score += board[loc];
      }
    }
  }
  return score * winning_num;
}

void mark_boards(int** boards, int boards_ct, int value, int* finished_ct) {
  for (int b=0; b<boards_ct; b++) {
    int* board = boards[b];
    if (!board) {
      continue;
    }
    int was_marked = mark_board(board, value);
    if (was_marked) {
      int is_win = is_line(board);
      if (is_win) {
        *finished_ct += 1;
        int score = score_board(boards[b], value);
        if (*finished_ct == 1) {
          printf("ex04 pt1 score %d\n", score);
        }
        if (*finished_ct == boards_ct) {
          printf("ex04 pt2 score %d\n", score);
        }
        boards[b] = NULL;
      }
    }
  }
}

int main() {

  char* input = read_input();
  int* boards[200];
  int boards_ct = 0;

  char* numbers_str = strtok(input, "\n");

  for (int i=0;i<200;i++) {
    int* board = malloc(sizeof(int[5][5]));

    if (read_board(board) < 1) {
      boards_ct = i;
      break;
    }
    boards[i] = board;
  }

  /* printf("boards: %d\n", boards_ct); */

  char* sinp = numbers_str;
  int finished_ct = 0;
  while (1) {
    char* num = strtok(sinp, ",");
    if (!num) {
      break;
    }
    int value = atoi(num);
    /* printf("called: %d\n", value); */
    mark_boards(boards, boards_ct, value, &finished_ct);
    if (finished_ct == boards_ct) {
        break;
    }
    /* printf("finished: %d\n", finished_ct); */
    sinp = NULL;
  }
}
