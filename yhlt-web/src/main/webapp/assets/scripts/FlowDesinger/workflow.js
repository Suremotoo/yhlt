﻿var wf_r = null,
wf_steps = [],
wf_texts = [],
wf_conns = [],
wf_option = "",
wf_focusObj = null,
wf_width = 108,
wf_height = 50,
wf_rect = 9,
wf_designer = !0,
wf_connColor = "#898a89",
wf_nodeBorderColor = "#23508e",
wf_noteColor = "#efeff0",
wf_stepDefaultName = "\u65b0\u6b65\u9aa4",
tempArrPath = [],
mouseX = 0,
mouseY = 0,
wf_json = {},
wf_id = "",
links_tables_fields = [];
$(function () {
    wf_r = Raphael("flowdiv", $(window).width(), $(window).height() - 28);
    wf_r.customAttributes.type1 = function () { };
    wf_r.customAttributes.fromid = function () { };
    wf_r.customAttributes.toid = function () { }
});
function addStep(a, b, c, d, e, g, f, k) {
    var l = getGuid(),
    h = getNewXY();
    a = a || h.x;
    b = b || h.y;
    c = c || wf_stepDefaultName;
    d = d || l;
    h = wf_r.rect(a, b, wf_width, wf_height, wf_rect);
    h.attr({
        fill: k || wf_noteColor,
        stroke: f || wf_nodeBorderColor,
        "stroke-width": 1,
        cursor: "default"
    });
    h.id = d;
    h.type1 = g ? g : "normal";
    h.drag(move, dragger, up);
    wf_designer && (h.click(click), "normal" == h.type1 ? h.dblclick(stepSetting) : "subflow" == h.type1 && h.dblclick(subflowSetting));
    wf_steps.push(h);
    f = 8 < c.length ? c.substr(0, 7) + "..." : c;
    f = wf_r.text(a + 52, b + 25, f);
    f.attr({
        "font-size": "12px"
    });
    8 < c.length && f.attr({
        title: c
    });
    f.id = "text_" + d;
    f.type1 = "text";
    wf_texts.push(f);
    if (void 0 == e || null == e) e = !0;
    e && (d = {},
    d.id = l, d.type = g ? g : "normal", d.name = c, d.position = {
        x: a,
        y: b,
        width: wf_width,
        height: wf_height
    },
    "normal" == h.type1 ? (d.opinionDisplay = "", d.expiredPrompt = "", d.signatureType = "", d.workTime = "", d.limitTime = "", d.otherTime = "", d.archives = "", d.archivesParams = "", d.note = "", d.behavior = {
        flowType: "",
        runSelect: "",
        handlerType: "",
        selectRange: "",
        handlerStep: "",
        valueField: "",
        defaultHandler: "",
        hanlderModel: "",
        backModel: "",
        backStep: "",
        backType: "",
        percentage: ""
    },
    d.forms = [], d.buttons = [], d.fieldStatus = [], d.event = {
        submitBefore: "",
        submitAfter: "",
        backBefore: "",
        backAfter: ""
    }) : "subflow" == h.type1 && (d.flowid = "", d.handler = "", d.strategy = 0), addStep1(d))
}
function addSubFlow() {
    addStep(null, null, "\u5b50\u6d41\u7a0b\u6b65\u9aa4", null, null, "subflow", null, null)
}
function copyStep() {
    if (null != wf_focusObj && isStepObj(wf_focusObj)) {
        var a = null,
        b = "",
        c = getGuid();
        if (wf_json && wf_json.steps) for (a = 0; a < wf_json.steps.length; a++) if (wf_json.steps[a].id == wf_focusObj.id) {
            a = wf_json.steps[a];
            a.id = c;
            b = a.name;
            a.name = b;
            break
        }
        addStep(void 0, void 0, b, c, !1)
    } else alert("\u8bf7\u9009\u62e9\u8981\u590d\u5236\u7684\u6b65\u9aa4")
}
function setStepText(a, b) {
    var c = wf_r.getById("text_" + a);
    null != c && (8 < b.length && (c.attr({
        title: b
    }), b = b.substr(0, 7) + "..."), c.attr({
        text: b
    }))
}
function removeObj() {
    if (!wf_focusObj) alert("\u8bf7\u9009\u62e9\u8981\u5220\u9664\u7684\u5bf9\u8c61!");
    else if (!confirm("\u60a8\u771f\u7684\u8981\u5220\u9664\u9009\u5b9a\u5bf9\u8c61\u5417?")) return !1;
    if (isStepObj(wf_focusObj)) {
        if (wf_focusObj.id) for (var a = 0; a < wf_texts.length; a++) if (wf_texts[a].id == "text_" + wf_focusObj.id) {
            wf_texts.remove(a);
            var b = wf_r.getById("text_" + wf_focusObj.id);
            b && b.remove()
        }
        a = [];
        for (b = 0; b < wf_conns.length; b++) !wf_conns[b].arrPath || wf_conns[b].obj1.id != wf_focusObj.id && wf_conns[b].obj2.id != wf_focusObj.id || (deleteLine(wf_conns[b].id), a.push(b), wf_conns[b].arrPath.remove());
        for (b = a.length; b--;) wf_conns.remove(a[b]);
        for (a = 0; a < wf_steps.length; a++) wf_steps[a].id == wf_focusObj.id && (wf_steps.remove(a), deleteStep(wf_focusObj.id))
    } else for (b = 0; b < wf_conns.length; b++) wf_conns[b].arrPath && wf_conns[b].arrPath.id == wf_focusObj.id && (deleteLine(wf_conns[b].id), wf_conns.remove(b));
    wf_focusObj.remove()
}
function getNewXY() {
    var a = 10,
    b = 50;
    0 < wf_steps.length && (b = wf_steps[wf_steps.length - 1], a = parseInt(b.attr("x")) + 170, b = parseInt(b.attr("y")), a > wf_r.width - wf_width && (a = 10, b += 100), b > wf_r.height - wf_height && (b = wf_r.height - wf_height));
    return {
        x: a,
        y: b
    }
}
function addConn() {
    if (!wf_focusObj || !isStepObj(wf_focusObj)) return alert("\u8bf7\u9009\u62e9\u8981\u8fde\u63a5\u7684\u6b65\u9aa4!"),
    !1;
    wf_option = "line";
    document.body.onmousemove = mouseMove;
    document.body.onmousedown = function () {
        for (var a = 0; a < tempArrPath.length; a++) tempArrPath[a].arrPath.remove();
        tempArrPath = [];
        document.body.onmousemove = null
    }
}
function mouseMove(a) {
    a = a || window.event;
    a = mouseCoords(a);
    mouseX = a.x;
    mouseY = a.y;
    wf_r.drawArr({
        obj1: wf_focusObj,
        obj2: null
    })
}
function mouseCoords(a) {
    return a.pageX || a.pageY ? {
        x: a.pageX,
        y: a.pageY
    } : {
        x: a.clientX + document.body.scrollLeft - document.body.clientLeft,
        y: a.clientY + document.body.scrollTop - document.body.clientTop
    }
}
function connObj(a, b, c) {
    if (void 0 == b || null == b) b = !0;
    isLine(a) && (c = wf_r.drawArr(a), wf_conns.push(c), b && (b = {},
    b.id = a.id, b.from = a.obj1.id, b.to = a.obj2.id, b.customMethod = "", b.sql = "", b.noaccordMsg = "", addLine(b)))
}
function click() {
    switch (wf_option) {
        case "line":
            var a = {
                id: getGuid(),
                obj1: wf_focusObj,
                obj2: this
            };
            connObj(a);
            break;
        default:
            changeStyle(this)
    }
    wf_option = "";
    wf_focusObj = this
}
function connClick() {
    for (var a = 0; a < wf_conns.length; a++) wf_conns[a].arrPath === this ? wf_conns[a].arrPath.attr({
        stroke: "#db0f14"
    }) : wf_conns[a].arrPath.attr({
        stroke: wf_connColor
    });
    for (a = 0; a < wf_steps.length; a++) wf_steps[a].attr("fill", "#efeff0"),
    wf_steps[a].attr("stroke", "#23508e");
    wf_focusObj = this
}
function isLine(a) {
    if (!(a && a.obj1 && a.obj2 && a.obj1 !== a.obj2 && isStepObj(a.obj1) && isStepObj(a.obj2))) return !1;
    for (var b = 0; b < wf_conns.length; b++) if (a.obj1 === a.obj2 || wf_conns[b].obj1 === a.obj1 && wf_conns[b].obj2 === a.obj2) return !1;
    return !0
}
function isStepObj(a) {
    return a && a.type1 && ("normal" == a.type1.toString() || "subflow" == a.type1.toString())
}
function getXmlDoc() {
    var a = RoadUI.Core.getXmlDoc();
    a.async = !1;
    return a
}
function getGuid() {
    return Raphael.createUUID().toLowerCase()
}
function changeStyle(a) {
    if (a) {
        for (var b = 0; b < wf_steps.length; b++) wf_steps[b].id == a.id ? (wf_steps[b].attr("fill", wf_noteColor), wf_steps[b].attr("stroke", "#cc0000")) : (wf_steps[b].attr("fill", wf_noteColor), wf_steps[b].attr("stroke", wf_nodeBorderColor));
        for (b = 0; b < wf_conns.length; b++) wf_conns[b].arrPath && wf_conns[b].arrPath.attr({
            stroke: wf_connColor
        })
    }
}
function dragger() {
    this.ox = this.attr("x");
    this.oy = this.attr("y");
    changeStyle(this)
}
function move(a, b) {
    var c = this.ox + a,
    d = this.oy + b;
    0 > c ? c = 0 : c > wf_r.width - wf_width && (c = wf_r.width - wf_width);
    0 > d ? d = 0 : d > wf_r.height - wf_height && (d = wf_r.height - wf_height);
    this.attr("x", c);
    this.attr("y", d);
    if (this.id) {
        var e = wf_r.getById("text_" + this.id);
        e && (e.attr("x", c + 52), e.attr("y", d + 25))
    }
    for (c = wf_conns.length; c--;) wf_conns[c].obj1.id != this.id && wf_conns[c].obj2.id != this.id || wf_r.drawArr(wf_conns[c]);
    wf_r.safari()
}
function up() {
    changeStyle(this);
    if (isStepObj(this)) {
        var a = this.getBBox();
        if (a) {
            var b = wf_json.steps;
            if (b && 0 < b.length) for (var c = 0; c < b.length; c++) if (b[c].id == this.id) {
                b[c].position = {
                    x: a.x,
                    y: a.y,
                    width: a.width,
                    height: a.height
                };
                break
            }
        }
    }
}
Raphael.fn.drawArr = function (a) {
    if (a && a.obj1) {
        if (a.obj2) {
            var b = getStartEnd(a.obj1, a.obj2),
            c = getArr(b.start.x, b.start.y, b.end.x, b.end.y, 9);
            try {
                a.arrPath ? a.arrPath.attr({
                    path: c
                }) : (a.arrPath = this.path(c), a.arrPath.attr({
                    "stroke-width": 2,
                    stroke: wf_connColor,
                    x: b.start.x,
                    y: b.start.y,
                    x1: b.end.x,
                    y1: b.end.y
                }), wf_designer && (a.arrPath.click(connClick), a.arrPath.dblclick(connSetting), a.arrPath.id = a.id, a.arrPath.fromid = a.obj1.id, a.arrPath.toid = a.obj2.id))
            } catch (d) { }
            return a
        }
        b = getStartEnd(a.obj1, a.obj2);
        b = getArr(b.start.x, b.start.y, mouseX, mouseY, 9);
        for (c = 0; c < tempArrPath.length; c++) tempArrPath[c].arrPath.remove();
        tempArrPath = [];
        a.arrPath = this.path(b);
        a.arrPath.attr({
            "stroke-width": 2,
            stroke: wf_connColor
        });
        tempArrPath.push(a)
    }
};
function setLineText(a, b) {
    for (var c, d = 0; d < wf_conns.length; d++) if (wf_conns[d].id == a) {
        c = wf_conns[d];
        break
    }
    if (c) {
        d = c.arrPath.getBBox();
        c = (d.x + d.x2) / 2;
        var d = (d.y + d.y2) / 2,
        e = wf_r.getById("line_" + a);
        null != e ? b ? (e.attr("x", c), e.attr("y", d), e.attr("text", b || "")) : e.remove() : b && (c = wf_r.text(c, d, b), c.type1 = "line", c.id = "line_" + a, wf_texts.push(c))
    }
}
function removeObj() {
    if (!wf_focusObj) alert("\u8bf7\u9009\u62e9\u8981\u5220\u9664\u7684\u5bf9\u8c61!");
    else if (!confirm("\u60a8\u771f\u7684\u8981\u5220\u9664\u9009\u5b9a\u5bf9\u8c61\u5417?")) return !1;
    if (isStepObj(wf_focusObj)) {
        if (wf_focusObj.id) for (var a = 0; a < wf_texts.length; a++) if (wf_texts[a].id == "text_" + wf_focusObj.id) {
            wf_texts.remove(a);
            var b = wf_r.getById("text_" + wf_focusObj.id);
            b && b.remove()
        }
        a = [];
        for (b = 0; b < wf_conns.length; b++) !wf_conns[b].arrPath || wf_conns[b].obj1.id != wf_focusObj.id && wf_conns[b].obj2.id != wf_focusObj.id || (deleteLine(wf_conns[b].id, wf_conns[b].arrPath.id), a.push(b), wf_conns[b].arrPath.remove());
        for (b = a.length; b--;) wf_conns.remove(a[b]);
        for (a = 0; a < wf_steps.length; a++) wf_steps[a].id == wf_focusObj.id && (wf_steps.remove(a), deleteStep(wf_focusObj.id))
    } else for (b = 0; b < wf_conns.length; b++) wf_conns[b].arrPath && wf_conns[b].arrPath.id == wf_focusObj.id && (deleteLine(wf_conns[b].id, wf_conns[b].arrPath.id), wf_conns.remove(b));
    wf_focusObj.remove()
}
function getNewXY() {
    var a = 10,
    b = 50;
    0 < wf_steps.length && (b = wf_steps[wf_steps.length - 1], a = parseInt(b.attr("x")) + 170, b = parseInt(b.attr("y")), a > wf_r.width - wf_width && (a = 10, b += 100), b > wf_r.height - wf_height && (b = wf_r.height - wf_height));
    return {
        x: a,
        y: b
    }
}
function addConn() {
    if (!wf_focusObj || !isStepObj(wf_focusObj)) return alert("\u8bf7\u9009\u62e9\u8981\u8fde\u63a5\u7684\u6b65\u9aa4!"),
    !1;
    wf_option = "line";
    document.body.onmousemove = mouseMove;
    document.body.onmousedown = function () {
        for (var a = 0; a < tempArrPath.length; a++) tempArrPath[a].arrPath.remove();
        tempArrPath = [];
        document.body.onmousemove = null
    }
}
function mouseMove(a) {
    a = a || window.event;
    a = mouseCoords(a);
    mouseX = a.x;
    mouseY = a.y;
    wf_r.drawArr({
        obj1: wf_focusObj,
        obj2: null
    })
}
function mouseCoords(a) {
    return a.pageX || a.pageY ? {
        x: a.pageX,
        y: a.pageY
    } : {
        x: a.clientX + document.body.scrollLeft - document.body.clientLeft,
        y: a.clientY + document.body.scrollTop - document.body.clientTop
    }
}
function connObj(a, b, c) {
    if (void 0 == b || null == b) b = !0;
    if (isLine(a)) {
        var d = wf_r.drawArr(a);
        wf_conns.push(d);
        b ? (b = {},
        b.id = a.id, b.text = c || "", b.from = a.obj1.id, b.to = a.obj2.id, b.customMethod = "", b.sql = "", b.noaccordMsg = "", addLine(b)) : setLineText(a.id, c)
    }
}
function click() {
    switch (wf_option) {
        case "line":
            var a = {
                id: getGuid(),
                obj1: wf_focusObj,
                obj2: this
            };
            connObj(a);
            break;
        default:
            changeStyle(this)
    }
    wf_option = "";
    wf_focusObj = this
}
function connClick() {
    for (var a = 0; a < wf_conns.length; a++) wf_conns[a].arrPath === this ? wf_conns[a].arrPath.attr({
        stroke: "#db0f14",
        fill: "#db0f14"
    }) : wf_conns[a].arrPath.attr({
        stroke: wf_connColor,
        fill: wf_connColor
    });
    for (a = 0; a < wf_steps.length; a++) wf_steps[a].attr("fill", "#efeff0"),
    wf_steps[a].attr("stroke", "#23508e");
    wf_focusObj = this
}
function isLine(a) {
    if (!(a && a.obj1 && a.obj2 && a.obj1 !== a.obj2 && isStepObj(a.obj1) && isStepObj(a.obj2))) return !1;
    for (var b = 0; b < wf_conns.length; b++) if (a.obj1 === a.obj2 || wf_conns[b].obj1 === a.obj1 && wf_conns[b].obj2 === a.obj2) return !1;
    return !0
}
function isStepObj(a) {
    return a && a.type1 && ("normal" == a.type1.toString() || "subflow" == a.type1.toString())
}
function getXmlDoc() {
    var a = RoadUI.Core.getXmlDoc();
    a.async = !1;
    return a
}
function getGuid() {
    return Raphael.createUUID().toLowerCase()
}
function changeStyle(a) {
    if (a) {
        for (var b = 0; b < wf_steps.length; b++) wf_steps[b].id == a.id ? (wf_steps[b].attr("fill", wf_noteColor), wf_steps[b].attr("stroke", "#cc0000")) : (wf_steps[b].attr("fill", wf_noteColor), wf_steps[b].attr("stroke", wf_nodeBorderColor));
        for (b = 0; b < wf_conns.length; b++) wf_conns[b].arrPath && wf_conns[b].arrPath.attr({
            stroke: wf_connColor,
            fill: wf_connColor
        })
    }
}
function dragger() {
    this.ox = this.attr("x");
    this.oy = this.attr("y");
    changeStyle(this)
}
function move(a, b) {
    var c = this.ox + a,
    d = this.oy + b;
    0 > c ? c = 0 : c > wf_r.width - wf_width && (c = wf_r.width - wf_width);
    0 > d ? d = 0 : d > wf_r.height - wf_height && (d = wf_r.height - wf_height);
    this.attr("x", c);
    this.attr("y", d);
    if (this.id) {
        var e = wf_r.getById("text_" + this.id);
        e && (e.attr("x", c + 52), e.attr("y", d + 25))
    }
    for (c = wf_conns.length; c--;) if (wf_conns[c].obj1.id == this.id || wf_conns[c].obj2.id == this.id) {
        for (d = 0; d < wf_json.lines.length; d++) if (wf_json.lines[d].id == wf_conns[c].arrPath.id) {
            setLineText(wf_json.lines[d].id, wf_json.lines[d].text);
            break
        }
        wf_r.drawArr(wf_conns[c])
    }
    wf_r.safari()
}
function up() {
    changeStyle(this);
    if (isStepObj(this)) {
        var a = this.getBBox();
        if (a) {
            var b = wf_json.steps;
            if (b && 0 < b.length) for (var c = 0; c < b.length; c++) if (b[c].id == this.id) {
                b[c].position = {
                    x: a.x,
                    y: a.y,
                    width: a.width,
                    height: a.height
                };
                break
            }
        }
    }
}
Raphael.fn.drawArr = function (a) {
    if (a && a.obj1) {
        if (a.obj2) {
            var b = getStartEnd(a.obj1, a.obj2),
            c = getArr(b.start.x, b.start.y, b.end.x, b.end.y, 7);
            try {
                a.arrPath ? a.arrPath.attr({
                    path: c
                }) : (a.arrPath = this.path(c), a.arrPath.attr({
                    "stroke-width": 1.7,
                    stroke: wf_connColor,
                    fill: wf_connColor,
                    x: b.start.x,
                    y: b.start.y,
                    x1: b.end.x,
                    y1: b.end.y
                }), wf_designer && (a.arrPath.click(connClick), a.arrPath.dblclick(connSetting), a.arrPath.id = a.id, a.arrPath.fromid = a.obj1.id, a.arrPath.toid = a.obj2.id))
            } catch (d) { }
            return a
        }
        b = getStartEnd(a.obj1, a.obj2);
        b = getArr(b.start.x, b.start.y, mouseX, mouseY, 7);
        for (c = 0; c < tempArrPath.length; c++) tempArrPath[c].arrPath.remove();
        tempArrPath = [];
        a.arrPath = this.path(b);
        a.arrPath.attr({
            "stroke-width": 1.7,
            stroke: wf_connColor,
            fill: wf_connColor
        });
        tempArrPath.push(a)
    }
};
function getStartEnd(a, b) {
    for (var c = a ? a.getBBox() : null, d = b ? b.getBBox() : null, c = [{
        x: c.x + c.width / 2,
        y: c.y - 1
    },
    {
        x: c.x + c.width / 2,
        y: c.y + c.height + 1
    },
    {
        x: c.x - 1,
        y: c.y + c.height / 2
    },
    {
        x: c.x + c.width + 1,
        y: c.y + c.height / 2
    },
    d ? {
        x: d.x + d.width / 2,
        y: d.y - 1
    } : {},
    d ? {
        x: d.x + d.width / 2,
        y: d.y + d.height + 1
    } : {},
    d ? {
        x: d.x - 1,
        y: d.y + d.height / 2
    } : {},
    d ? {
        x: d.x + d.width + 1,
        y: d.y + d.height / 2
    } : {}], d = {},
    e = [], g = 0; 4 > g; g++) for (var f = 4; 8 > f; f++) {
        var k = Math.abs(c[g].x - c[f].x),
        l = Math.abs(c[g].y - c[f].y);
        if (g == f - 4 || (3 != g && 6 != f || c[g].x < c[f].x) && (2 != g && 7 != f || c[g].x > c[f].x) && (0 != g && 5 != f || c[g].y > c[f].y) && (1 != g && 4 != f || c[g].y < c[f].y)) e.push(k + l),
        d[e[e.length - 1]] = [g, f]
    }
    d = 0 == e.length ? [0, 4] : d[Math.min.apply(Math, e)];
    e = {
        start: {},
        end: {}
    };
    e.start.x = c[d[0]].x;
    e.start.y = c[d[0]].y;
    e.end.x = c[d[1]].x;
    e.end.y = c[d[1]].y;
    return e
}
function getArr(a, b, c, d, e) {
    var g = Raphael.angle(a, b, c, d),
    f = Raphael.rad(g - 28),
    k = Raphael.rad(g + 28),
    g = c + Math.cos(f) * e,
    f = d + Math.sin(f) * e,
    l = c + Math.cos(k) * e;
    e = d + Math.sin(k) * e;
    return ["M", a, b, "L", c, d, "M", c, d, "L", l, e, "L", g, f, "z"].join()
}
function initwf() {
    wf_json = {};
    wf_steps = [];
    wf_texts = [];
    wf_conns = [];
    wf_r.clear()
}
Array.prototype.remove = function (a) {
    if (isNaN(a) || a > this.length) return !1;
    this.splice(a, 1)
};
function removeArray(a, b) {
    if (isNaN(b) || b > a.length) return !1;
    a.splice(b, 1)
}
function getTables(a) {
    var b = [];
    $.ajax({
        url: "WorkFlowDesigner/GetTables?connid\x3d" + a,
        dataType: "json",
        async: !1,
        cache: !1,
        success: function (a) {
            for (var d = 0; d < a.length; d++) b.push(a[d])
        }
    });
    return b
}
function getFields(a, b) {
    var c = [];
    $.ajax({
        url: "WorkFlowDesigner/GetFields?connid\x3d" + a + "\x26table\x3d" + b,
        dataType: "json",
        async: !1,
        cache: !1,
        success: function (a) {
            for (var b = 0; b < a.length; b++) c.push(a[b])
        }
    });
    return c
}
function initLinks_Tables_Fields(a) {
    if (a && 0 != a.length) {
        links_tables_fields = [];
        for (var b = 0; b < a.length; b++) for (var c = getFields(a[b].link, a[b].table), d = 0; d < c.length; d++) links_tables_fields.push({
            link: a[b].link,
            linkName: a[b].linkName,
            table: a[b].table,
            field: c[d].name,
            fieldNote: c[d].note
        })
    }
}
function addStep1(a) {
    if (a) {
        wf_json.steps || (wf_json.steps = []);
        for (var b = !1,
        c = 0; c < wf_json.steps.length; c++) wf_json.steps[c].id == a.id && (wf_json.steps[c] = a, b = !0);
        b || wf_json.steps.push(a)
    }
}
function addLine(a) {
    if (a && a.from && a.to) {
        wf_json.lines || (wf_json.lines = []);
        for (var b = !1,
        c = 0; c < wf_json.lines.length; c++) wf_json.lines[c].id == a.id && (wf_json.lines[c] = a, b = !0);
        b || wf_json.lines.push(a);
        setLineText(a.id, a.text)
    }
}
function reloadFlow(a) {
    if (!a || !a.id || "" == $.trim(a.id)) return !1;
    wf_json = a;
    wf_id = wf_json.id;
    wf_r.clear();
    wf_steps = [];
    wf_conns = [];
    wf_texts = [];
    var b = wf_json.steps;
    if (b && 0 < b.length) for (a = 0; a < b.length; a++) addStep(b[a].position.x, b[a].position.y, b[a].name, b[a].id, !1, b[a].type);
    if ((b = wf_json.lines) && 0 < b.length) for (a = 0; a < b.length; a++) connObj({
        id: b[a].id,
        obj1: wf_r.getById(b[a].from),
        obj2: wf_r.getById(b[a].to)
    },
    !1, b[a].text);
    initLinks_Tables_Fields(wf_json.databases)
}
function deleteStep(a) {
    var b = wf_json.steps;
    if (b && 0 < b.length) for (var c = 0; c < b.length; c++) b[c].id == a && removeArray(b, c)
}
function deleteLine(a, b) {
    var c = wf_json.lines;
    if (c && 0 < c.length) for (var d = 0; d < c.length; d++) c[d].id == a && removeArray(c, d);
    if (b && wf_texts && 0 < wf_texts.length) for (d = 0; d < wf_texts.length; d++) wf_texts[d].id == "line_" + b && wf_texts[d].remove()
}
function stepSetting() {
    var a = this.getBBox();
    dialog.open({
        title: "\u6b65\u9aa4\u53c2\u6570\u8bbe\u7f6e",
        width: 700,
        height: 400,
        url: top.rootdir + "/WorkFlowDesigner/Set_Step?appid\x3d" + appid + "\x26id\x3d" + this.id + "\x26x\x3d" + a.x + "\x26y\x3d" + a.y + "\x26width\x3d" + a.width + "\x26height\x3d" + a.height,
        openerid: iframeid,
        resize: !1
    })
}
function subflowSetting() {
    var a = this.getBBox();
    dialog.open({
        title: "\u5b50\u6d41\u7a0b\u6b65\u9aa4\u53c2\u6570\u8bbe\u7f6e",
        width: 700,
        height: 400,
        url: top.rootdir + "/WorkFlowDesigner/Set_SubFlow?appid\x3d" + appid + "\x26id\x3d" + this.id + "\x26x\x3d" + a.x + "\x26y\x3d" + a.y + "\x26width\x3d" + a.width + "\x26height\x3d" + a.height,
        openerid: iframeid,
        resize: !1
    })
}
function connSetting() {
    dialog.open({
        title: "\u6d41\u8f6c\u6761\u4ef6\u8bbe\u7f6e",
        width: 700,
        height: 400,
        url: top.rootdir + "/WorkFlowDesigner/Set_Line?appid\x3d" + appid + "\x26id\x3d" + this.id + "\x26from\x3d" + this.fromid + "\x26to\x3d" + this.toid,
        openerid: iframeid,
        resize: !1
    })
}
function flowAttrSetting(a) {
    //alert(top.rootdir + "/WorkFlowDesigner/Set_Flow?appid\x3d" + appid + "\x26isadd\x3d" + (a || 0).toString() + "\x26flowid\x3d" + wf_json.id);
    dialog.open({
        title: "\u6d41\u7a0b\u5c5e\u6027\u8bbe\u7f6e",
        width: 550,
        height: 390,
        url: top.rootdir + "/WorkFlowDesigner/Set_Flow?appid\x3d" + appid + "\x26isadd\x3d" + (a || 0).toString() + "\x26flowid\x3d" + wf_json.id,
        openerid: iframeid,
        resize: !1
    })
}
function openFlow() {
    dialog.open({
        title: "\u6253\u5f00\u6d41\u7a0b",
        width: 850,
        height: 450,
        url: top.rootdir + "/WorkFlowDesigner/Open?appid\x3d" + appid,
        openerid: iframeid,
        resize: !1
    })
}
function openFlow1(a) {
    $.ajax({
        url: top.rootdir + "/WorkFlowDesigner/GetJSON?appid\x3d" + appid + "\x26flowid\x3d" + a,
        async: !1,
        cache: !1,
        dataType: "json",
        success: function (a) {
            reloadFlow(a)
        }
    })
}
function addFlow() {
    flowAttrSetting(1)
}
function saveFlow(a) {
    if (wf_json) {
        if (!wf_json.id || "" == $.trim(wf_json.id)) return alert("\u8bf7\u5148\u65b0\u5efa\u6216\u6253\u5f00\u6d41\u7a0b!"),
        !1;
        if (!wf_json.name || "" == $.trim(wf_json.name)) return alert("\u6d41\u7a0b\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a!"),
        !1
    } else return alert("\u672a\u8bbe\u7f6e\u6d41\u7a0b!"),
    !1;
    if ("delete" != a || confirm("\u60a8\u771f\u7684\u8981\u5220\u9664\u8be5\u6d41\u7a0b\u5417?")) {
        var b = "";
        "save" == a ? b = "\u4fdd\u5b58\u6d41\u7a0b" : "install" == a ? b = "\u5b89\u88c5\u6d41\u7a0b" : "uninstall" == a ? b = "\u5378\u8f7d\u6d41\u7a0b" : "delete" == a && (b = "\u5220\u9664\u6d41\u7a0b");
        dialog.open({
            title: b,
            width: 260,
            height: 120,
            url: top.rootdir + "/WorkFlowDesigner/Opation?appid\x3d" + appid + "\x26flowid\x3d" + wf_json.id + "\x26op\x3d" + (a || "save"),
            openerid: iframeid,
            resize: !1,
            showclose: !1
        })
    }
}
function saveAs() {
    if (!wf_json || !wf_json.id || "" == $.trim(wf_json.id)) return alert("\u8bf7\u5148\u65b0\u5efa\u6216\u6253\u5f00\u4e00\u4e2a\u6d41\u7a0b!"),
    !1;
    dialog.open({
        title: "\u6d41\u7a0b\u53e6\u5b58\u4e3a",
        width: 600,
        height: 230,
        url: top.rootdir + "/WorkFlowDesigner/SaveAs?appid\x3d" + appid + "\x26flowid\x3d" + wf_json.id,
        openerid: iframeid,
        resize: !1
    })
};