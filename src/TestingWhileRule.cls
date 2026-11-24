// Bad Practice: while loop body without curly braces.
public with sharing class SF0004WhileWithoutBracesBad {
    public static Integer countDown(Integer start) {
        Integer counter = start;
        while (counter > 0) counter--;
        return counter;
    }
}
