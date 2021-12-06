import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.stream.Collectors;
import java.util.List;
import java.util.HashMap;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.File;
import java.io.IOException;


class Aoc5 {
    public static void main(String[] args) throws IOException {
        List<String> lines = Files.readAllLines(Paths.get("data/05"));
        Pattern p = Pattern.compile("(\\d+),(\\d+) -> (\\d+),(\\d+)");
        List<Arrow> arrows = lines.stream().map(line -> {
                Matcher matcher = p.matcher(line);
                matcher.matches();
                var x1 = Integer.parseInt(matcher.group(1));
                var y1 = Integer.parseInt(matcher.group(2));
                var x2 = Integer.parseInt(matcher.group(3));
                var y2 = Integer.parseInt(matcher.group(4));
                return new Arrow(x1, y1, x2, y2);
            })
            .collect(Collectors.toList());
        Board board = new Board();
        arrows.stream().forEach(a -> board.addArrow(a, false));
        var overlaps = board.countOverlaps();
        System.out.printf("ex5 pt1 %d\n", overlaps);

        Board board2 = new Board();
        arrows.stream().forEach(a -> board2.addArrow(a, true));
        var overlaps2 = board2.countOverlaps();
        System.out.printf("ex5 pt2 %d\n", overlaps2);
    }
}

class Board {
    HashMap<Integer, HashMap<Integer, Integer>> counts;

    Board() {
        this.counts = new HashMap<>();
    }

    void addArrow(Arrow arrow, boolean withDiagonal) {
        if (arrow.isHorizontal()) {
            var dirn = arrow.x1 < arrow.x2 ? 1 : -1;
            var diff = Math.abs(arrow.x2 - arrow.x1);
            for (int i =0; i <= diff; i++) {
                addCoord(arrow.x1 + i * dirn, arrow.y1);
            }
        } else if (arrow.isVertical()) {
            var dirn = arrow.y1 < arrow.y2 ? 1 : -1;
            var diff = Math.abs(arrow.y2 - arrow.y1);
            for (int i =0; i <= diff; i++) {
                addCoord(arrow.x1, arrow.y1 + i * dirn);
            }
        } else if (withDiagonal && arrow.isDiagonal()) {
            var xdirn = arrow.x1 < arrow.x2 ? 1 : -1;
            var ydirn = arrow.y1 < arrow.y2 ? 1 : -1;
            var diff = Math.abs(arrow.y2 - arrow.y1);
            for (int i=0; i<=diff; i++) {
                addCoord(arrow.x1 + i * xdirn, arrow.y1 + i * ydirn);
            }
        }
    }

    void addCoord(int x, int y) {
        this.counts.computeIfAbsent(x, k -> new HashMap<>()).compute(y, (k, v) -> {
                return v == null ? 1 : v + 1;
            });
    }

    int countOverlaps() {
        return this.counts.values().stream().reduce(0, (sum, inner) -> {
                return sum +  inner
                    .values()
                    .stream()
                    .reduce(0, (sum2, v) -> sum2 + ((v > 1) ? 1 : 0), Integer::sum);
            }, Integer::sum);
    }
}

class Arrow {
    int x1;
    int y1;
    int x2;
    int y2;

    Arrow(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.x2 = x2;
        this.y1 = y1;
        this.y2 = y2;
    }

    boolean isHorizontal() {
        return this.y1 == this.y2;
    }

    boolean isVertical() {
        return this.x1 == this.x2;
    }

    boolean isDiagonal() {
        return Math.abs(this.x2 - this.x1) == Math.abs(this.y2 - this.y1);
    }
}
