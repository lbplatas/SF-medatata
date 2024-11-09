({
    rerender: function (component, helper) {
	alert('I am an alert');
        this.superRerender();
        window.setTimeout(
            $A.getCallback(function () {
                if (component.isValid()) {
                    var el = component.find('content').getElement();
                    el.scrollTop = el.scrollHeight;
                }
            }),
            200
        );
	var a = 5;
	return a;
    }
});
